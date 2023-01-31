from django.urls import path
from bank import views

urlpatterns = [
    path('create-read-safebox/', views.SafeboxReadAndCreate.as_view()),
    path('delete-update-safebox/', views.SafeboxDeleteAndUpdate.as_view()),
    path('discharge-safebox/', views.discharge_safebox),
    path('get-contracts/', views.ContractList.as_view()),
]