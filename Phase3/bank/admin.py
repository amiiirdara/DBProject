from django.contrib import admin

# Register your models here.
from bank.models import Bank, Safebox, Hall, Customer, Contract, Employee, Businessplan, Account, Timeplan, Expiration

admin.site.register(Bank)
admin.site.register(Safebox)
admin.site.register(Customer)
admin.site.register(Hall)
admin.site.register(Contract)
admin.site.register(Employee)
admin.site.register(Businessplan)
admin.site.register(Account)
admin.site.register(Timeplan)
admin.site.register(Expiration)