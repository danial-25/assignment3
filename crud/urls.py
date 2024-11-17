from django.urls import path
from . import views

urlpatterns = [
    path("users/create/", views.create_user, name="create_user"),
    path(
        "user/<str:email>/", views.UserView.as_view(), name="user_detail_update_delete"
    ),
    path("diseases/list", views.patients_with_diseases),
    path("diseases/report/<str:check>/", views.view_records),
    path("diseases/report_create/", views.create_record),
    path("diseases/discover/<str:country>/", views.view_discoveries),
    path("countries", views.CountryView.as_view()),
    path("specialize", views.specialize),
]
