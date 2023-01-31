from rest_framework import serializers

from bank.models import Safebox, Customer, Timeplan, Contract


class SafeboxSerializer(serializers.ModelSerializer):

    class Meta:
        model = Safebox
        fields = '__all__'

class DischargeSafeboxSerializer(serializers.Serializer):
    safebox_id = serializers.IntegerField()

class CustomerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Customer
        fields = '__all__'

class TimePlanSerializer(serializers.ModelSerializer):

    class Meta:
        model = Timeplan
        fields = '__all__'

class ContractSerializer(serializers.ModelSerializer):
    safebox = SafeboxSerializer()
    customer_national = CustomerSerializer()
    time_plan_duration = TimePlanSerializer()

    class Meta:
        model = Contract
        fields = '__all__'
