from django.shortcuts import render
from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAdminUser
from rest_framework.response import Response
from .models import *
from django.shortcuts import get_object_or_404
from .serializers import *
from rest_framework import status
import requests


@api_view(["GET"])
@permission_classes([AllowAny])
def user_info(request):
    email = request.query_params.get("email")
    user = get_object_or_404(Users, email=email)
    serializer = UsersSerializer(user)
    return Response(serializer.data)


@api_view(["PUT"])
@permission_classes([IsAdminUser])
def update_user(request, email):
    user = get_object_or_404(Users, email=email)
    serializer = UsersSerializer(user, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([AllowAny])
def create_user(request):
    serializer = UsersSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["DELETE"])
@permission_classes([IsAdminUser])
def delete_user(request, email):
    user = get_object_or_404(Users, email=email)
    user.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)


@api_view(["GET"])
@permission_classes([AllowAny])
def patients_with_diseases(request):
    email = request.query_params.get("email")
    is_public_servant = Publicservant.objects.filter(email=email).exists()
    is_doctor = Doctor.objects.filter(email=email).exists()

    if not (is_public_servant or is_doctor):
        return Response({"error": "Access denied. User is not authorized."}, status=403)
    data = []
    patients = Patients.objects.all()

    for patient in patients:
        ps = UsersSerializer(patient.email)
        diss = Patientdisease.objects.filter(email=patient.email).values_list(
            "disease_code", flat=True
        )

        d_info = []
        for d in diss:
            d = Disease.objects.get(disease_code=d)
            ds = DiseaseSerializer(d)
            d_info.append(ds.data)

        # Append each patient's data
        data.append(
            {
                "patient": ps.data,
                "diseases": d_info,
            }
        )

    return Response(data)


@api_view(["GET"])
@permission_classes([AllowAny])
def view_discoveries(request, country):
    discovers = Discover.objects.filter(cname=country)
    if not discovers.exists():
        discovers = Discover.objects.all()
    discovers = DiscoverSerializer(discovers, many=True)
    return Response(discovers.data)


@api_view(["GET"])
@permission_classes([AllowAny])
def view_records(request, check):

    if "@" in check:  # Basic email validation
        records = Record.objects.filter(email=check)
    else:
        records = Record.objects.filter(cname=check)
    if not records.exists():
        records = Record.objects.all()
    records = RecordSerializer(records, many=True)
    return Response(records.data)


@api_view(["POST"])
@permission_classes([AllowAny])
def create_record(request):
    if request.method == "POST":
        email = request.data.get("email")
        cname = request.data.get("cname")
        disease_code = request.data.get("disease_code")
        total_deaths = request.data.get("total_deaths")
        total_patients = request.data.get("total_patients")

        # Check if the PublicServant exists
        public_servant = Publicservant.objects.filter(email=email).first()
        if not public_servant:
            return Response(
                {"error": "The provided email does not belong to a PublicServant."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Check if the combination of email, cname, and disease_code already exists
        if Record.objects.filter(
            email=public_servant, cname=cname, disease_code=disease_code
        ).exists():
            return Response(
                {
                    "error": "Record with the same email, country, and disease code already exists."
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Check if the country exists
        country = Country.objects.filter(cname=cname).first()
        if not country:
            url = "https://countriesnow.space/api/v0.1/countries/population"
            data = {"country": cname}
            response = requests.post(url, data=data)
            if response.status_code == 200:
                response_data = response.json()
                try:
                    population = response_data.get("data")["populationCounts"][-1][
                        "value"
                    ]
                    country = Country.objects.create(cname=cname, population=population)
                except (KeyError, IndexError):
                    return Response(
                        {
                            "error": "Population data for the country could not be retrieved."
                        },
                        status=status.HTTP_400_BAD_REQUEST,
                    )
            else:
                return Response(
                    {"error": "Request to external API failed."},
                    status=status.HTTP_400_BAD_REQUEST,
                )
        disease = Disease.objects.filter(disease_code=disease_code).first()
        if not disease:
            return Response(
                {"error": "The provided disease code does not exist."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Validate total deaths and total patients
        if not total_deaths or not total_patients:
            return Response(
                {"error": "Total deaths and total patients are required."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        record_data = {
            "email": public_servant,
            "cname": country,
            "disease_code": disease,
            "total_deaths": total_deaths,
            "total_patients": total_patients,
        }
        try:
            record = Record.objects.create(**record_data)
            return Response(
                RecordSerializer(record).data, status=status.HTTP_201_CREATED
            )
        except Exception as e:
            return Response(
                {"error": f"Error creating record: {str(e)}"},
                status=status.HTTP_400_BAD_REQUEST,
            )



