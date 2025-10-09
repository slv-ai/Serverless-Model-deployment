import boto3
import json
lambda_client = boto3.client('lambda', region_name='us-east-1')
customer_data =  {
  "customer": {
    "gender": "female",
    "seniorcitizen": 0,
    "partner": "yes",
    "dependents": "no",
    "phoneservice": "no",
    "multiplelines": "no_phone_service",
    "internetservice": "dsl",
    "onlinesecurity": "no",
    "onlinebackup": "yes",
    "deviceprotection": "no",
    "techsupport": "no",
    "streamingtv": "no",
    "streamingmovies": "no",
    "contract": "month-to-month",
    "paperlessbilling": "yes",
    "paymentmethod": "electronic_check",
    "tenure": 1,
    "monthlycharges": 29.85,
    "totalcharges": 29.85
  }
}
response = lambda_client.invoke(
    FunctionName='churn_prediction_docker',
    InvocationType='RequestResponse',
    Payload=json.dumps(customer_data)
)  
result = json.loads(response['Payload'].read())
print(json.dumps(result,indent=2))