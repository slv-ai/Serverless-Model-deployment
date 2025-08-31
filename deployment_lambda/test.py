import json
import requests
url="http://localhost:8080/2015-03-31/functions/function/invocations"
with open("customer.json",'rb')as f_in:
    customer=json.load(f_in)
result=requests.post(url,json=customer).json()
print(result)