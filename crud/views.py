from django.shortcuts import render
from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from .models import *
from django.shortcuts import get_object_or_404
from .serializers import *
from rest_framework import status
import requests


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from rest_framework import status
from django.shortcuts import get_object_or_404
from .models import Users
from .serializers import UsersSerializer


class UserView(APIView):
    def get_permissions(self):
        if self.request.method in ["PUT", "DELETE"]:
            return [IsAuthenticated()]
        return [AllowAny()]

    def get(self, request, email):
        # email = request.query_params.get("email")
        user = get_object_or_404(Users, email=email)
        serializer = UsersSerializer(user)
        return Response(serializer.data)

    def put(self, request, email):
        user = get_object_or_404(Users, email=email)
        serializer = UsersSerializer(user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, email):
        user = get_object_or_404(Users, email=email)
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class CountryView(APIView):
    def get_permissions(self):
        if self.request.method in ["POST"]:
            return [IsAuthenticated()]
        return [AllowAny()]

    def get(self, request):
        countries = Country.objects.all()
        serializer = CountrySerializer(countries, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = CountrySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
@permission_classes([AllowAny])
def create_user(request):
    serializer = UsersSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


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
def specialize(request):
    specialize_records = Specialize.objects.select_related("email", "disease").all()
    serializer = SpecializeSerializer(specialize_records, many=True)
    return Response(serializer.data)


@api_view(["GET"])
@permission_classes([AllowAny])
def view_records(request, check):

    if "@" in check:
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
    email = request.data.get("email")
    cname = request.data.get("cname")
    disease_code = request.data.get("disease_code")
    total_deaths = request.data.get("total_deaths")
    total_patients = request.data.get("total_patients")

    try:
        public_servant = Publicservant.objects.get(email=email)
    except Exception:
        return Response(
            {"error": "public servant doesn't exist"},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if Record.objects.filter(
        email=public_servant, cname=cname, disease_code=disease_code
    ).exists():
        return Response(
            {
                "error": "Record with the same email, country, and disease code already exists."
            },
            status=status.HTTP_400_BAD_REQUEST,
        )

    try:
        country = Country.objects.get(cname=cname)
    except Exception:
        url = "https://countriesnow.space/api/v0.1/countries/population"
        response = requests.post(url, json={"country": cname})
        if response.status_code == 200:
            try:
                population = response.json()["data"]["populationCounts"][-1]["value"]
                country = Country.objects.create(cname=cname, population=population)
            except Exception:
                return Response(
                    {"error": "Error during fetching"},
                    status=status.HTTP_400_BAD_REQUEST,
                )
        else:
            return Response(
                {"error": "Country info wasn't fetched."},
                status=status.HTTP_400_BAD_REQUEST,
            )

    try:
        disease = Disease.objects.get(disease_code=disease_code)
    except Exception:
        return Response(
            {"error": "The provided disease code does not exist."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if not total_deaths or not total_patients:
        return Response(
            {"error": "Total deaths and total patients are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    try:
        record = Record.objects.create(
            email=public_servant,
            cname=country,
            disease_code=disease,
            total_deaths=total_deaths,
            total_patients=total_patients,
        )
        return Response(RecordSerializer(record).data)
    except Exception:
        return Response(status=status.HTTP_400_BAD_REQUEST)
