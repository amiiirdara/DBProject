from django.db import models


class Account(models.Model):
    account_id = models.IntegerField(primary_key=True)
    national = models.ForeignKey('Customer', models.DO_NOTHING, blank=True, null=True)
    balance = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'account'


class Address(models.Model):
    national = models.OneToOneField('Customer', models.DO_NOTHING, primary_key=True)
    address = models.CharField(max_length=75)

    class Meta:
        managed = False
        db_table = 'address'
        unique_together = (('national', 'address'),)


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Bank(models.Model):
    bank_id = models.IntegerField(primary_key=True)
    bank_name = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'bank'


class Businessplan(models.Model):
    business_plan_id = models.IntegerField(primary_key=True)
    discount = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'businessplan'


class Contract(models.Model):
    safebox = models.OneToOneField('Safebox', models.DO_NOTHING, primary_key=True)
    time = models.DateField(unique=True, null=False, auto_now_add=True)
    customer_national = models.ForeignKey('Customer', models.DO_NOTHING, blank=True, null=True)
    time_plan_duration = models.ForeignKey('Timeplan', models.DO_NOTHING, db_column='time_plan_duration', blank=True, null=True)
    cost = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'contract'
        unique_together = (('safebox', 'time'),)


class Contractservice(models.Model):
    safebox = models.OneToOneField(Contract,models.DO_NOTHING, primary_key=True)
    contract_time = models.ForeignKey(Contract, related_name='contract_services',on_delete=models.DO_NOTHING, db_column='contract_time', to_field='time')
    service = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'contractservice'
        unique_together = (('safebox', 'contract_time', 'service'),)


class Customer(models.Model):
    national_id = models.CharField(primary_key=True, max_length=10)
    bank = models.ForeignKey(Bank, models.DO_NOTHING, blank=True, null=True)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    age = models.IntegerField(blank=True, null=True)
    is_commercial = models.IntegerField()
    business_plan = models.ForeignKey(Businessplan, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'customer'


class Damage(models.Model):
    safebox = models.OneToOneField(Contract, models.DO_NOTHING, primary_key=True)
    start_time = models.ForeignKey(Contract, related_name='damages',on_delete=models.DO_NOTHING, db_column='start_time', to_field='time')
    end_time = models.DateField()
    description = models.CharField(max_length=150, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'damage'
        unique_together = (('safebox', 'start_time'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Employee(models.Model):
    national_id = models.CharField(primary_key=True, max_length=10)
    bank = models.ForeignKey(Bank, models.DO_NOTHING, blank=True, null=True)
    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    password = models.CharField(max_length=32)
    salary = models.BigIntegerField(blank=True, null=True)
    is_responsible = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employee'


class Expiration(models.Model):
    safebox = models.OneToOneField('Safebox', models.DO_NOTHING, primary_key=True)
    start_time = models.DateField()
    end_time = models.DateField(blank=True, null=True)
    customer_national = models.ForeignKey(Customer, models.DO_NOTHING, blank=True, null=True)
    type = models.CharField(max_length=9, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'expiration'
        unique_together = (('safebox', 'start_time'),)


class Fiduciary(models.Model):
    safebox = models.OneToOneField(Contract, models.DO_NOTHING, primary_key=True)
    time = models.ForeignKey(Contract, related_name='fiduciaries', on_delete=models.DO_NOTHING, db_column='time', to_field='time')
    description = models.CharField(max_length=150, blank=True, null=True)
    value = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'fiduciary'
        unique_together = (('safebox', 'time'),)


class Hall(models.Model):
    floor = models.IntegerField(primary_key=True)
    wall_material = models.IntegerField()
    number_of_cameras = models.IntegerField()
    security_level = models.IntegerField(blank=True, null=True)
    employee_national = models.ForeignKey(Employee, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'hall'


class Report(models.Model):
    national = models.OneToOneField(Contract, models.DO_NOTHING, primary_key=True)
    hall_floor = models.ForeignKey(Hall, models.DO_NOTHING, db_column='hall_floor', blank=True, null=True)
    time = models.DateField()

    class Meta:
        managed = False
        db_table = 'report'
        unique_together = (('national', 'time'),)


class Safebox(models.Model):
    safebox_id = models.IntegerField(primary_key=True)
    hall_floor = models.ForeignKey(Hall, models.DO_NOTHING, db_column='hall_floor', blank=True, null=True)
    price_class = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'safebox'


class Safeboxinfo(models.Model):
    safebox = models.OneToOneField(Safebox, models.DO_NOTHING, primary_key=True)
    info = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'safeboxinfo'
        unique_together = (('safebox', 'info'),)


class Timeplan(models.Model):
    duration = models.SmallIntegerField(primary_key=True)
    discount = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'timeplan'
