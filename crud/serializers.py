from rest_framework import serializers
from .models import *


class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = ["email", "first_name", "surname", "salary", "phone", "cname"]


class DiseaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Disease
        fields = ["disease_code", "pathogen", "description", "disease_id"]


class RecordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Record
        fields = ["email", "cname", "disease_code", "total_deaths", "total_patients"]


class DiscoverSerializer(serializers.ModelSerializer):
    class Meta:
        model = Discover
        fields = ["cname", "disease_code", "first_enc_date"]


class CountrySerializer(serializers.ModelSerializer):
    class Meta:
        model = Country
        fields = ["cname", "population"]


class DiseasetypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Diseasetype
        fields = ["id", "description"] 


class SpecializeSerializer(serializers.ModelSerializer):
    doctor = UsersSerializer(source='email.email')
    disease_type = DiseasetypeSerializer(source='disease')

    class Meta:
        model = Specialize
        fields = ['doctor', 'disease_type']