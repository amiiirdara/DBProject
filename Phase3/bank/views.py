import datetime
from datetime import date

from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from bank.models import Safebox, Expiration, Contract
from bank.serializers import SafeboxSerializer, DischargeSafeboxSerializer, ContractSerializer


class SafeboxReadAndCreate(generics.ListCreateAPIView):
    serializer_class = SafeboxSerializer
    queryset = Safebox.objects.all()

    def list(self, request, *args, **kwargs):
        safeboxes = Safebox.objects.all()
        result = []
        for safebox in safeboxes:
            serialized = SafeboxSerializer(safebox)
            safebox_dict = dict(serialized.data)
            contract = Contract.objects.filter(safebox=safebox)
            if len(contract) == 0:
                safebox_dict["rentable"] = True
            else:
                safebox_dict["rentable"] = False
            result.append(safebox_dict)
        return Response(result, status=status.HTTP_200_OK)


class SafeboxDeleteAndUpdate(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SafeboxSerializer
    queryset = Safebox.objects.all()

@api_view(['PUT'])
def discharge_safebox(request):
    serialized_data = DischargeSafeboxSerializer(data=request.data)
    if serialized_data.is_valid():
        try:
            safebox = Safebox.objects.get(safebox_id=serialized_data.data['safebox_id'])
        except:
            safebox = None
        if safebox is None:
            return Response({"message": "safebox with this id doesn't exist"}, status=status.HTTP_400_BAD_REQUEST)
        try:
            contract = Contract.objects.get(safebox=safebox)
        except:
            contract = None
        if contract is None:
            return Response({"message": "this safebox is empty now"}, status=status.HTTP_400_BAD_REQUEST)
        today = date.today()
        expiration = Expiration(
            safebox=safebox,
            customer_national=contract.customer_national,
            start_time=contract.time,
            end_time=datetime.date(year=today.year, month=today.month, day=today.day),
            type='discharge'
        )
        expiration.save()
        contract.delete()
        return Response({"message": "discharging was successfully"}, status=status.HTTP_200_OK)
    return Response(serialized_data.errors, status=status.HTTP_400_BAD_REQUEST)

class ContractList(generics.ListAPIView):
    serializer_class = ContractSerializer
    queryset = Contract.objects.all()
