from django.urls import path
from . import views

urlpatterns = [
    path("users/info", views.user_info, name="user_info"),
    path("users/update/<str:email>/", views.update_user, name="update_user"),
    path("users/create/", views.create_user, name="create_user"),
    path("users/delete/<str:email>/", views.delete_user, name="delete_user"),
    path("diseases/list", views.patients_with_diseases),
    path("diseases/report/<str:check>/", views.view_records),
    path("diseases/report_create/", views.create_record),
    path("diseases/discover/<str:country>/", views.view_discoveries),
]
