# Serverless-Model-deployment

## AWS Lambda with Docker - Running locally
1. create a lambda function & build docker image
```
docker build -t churn-prediction-lambda .
```
2. Run & test it 
```
docker run -it --rm -p 8080:8080  churn-prediction-lambda
```
```
python test.py
```
```
{'churn_probability': 0.6638167617162171, 'churn': True}
```

## Publish Docker image to ECR  repo to store images and test it
1. create ECR registry 
```
aws ecr create-repository \
  --repository-name "churn-prediction-lambda" \
  --region "us-east-1"
```


2. login to ecr & build and push the image to ecr  and test it
```
aws ecr get-login-password \
  --region "us-east-1"
|  docker login \
  --username AWS \
  --password-stdin ${ECR_URL}

```

```
bash deploy.sh
python invoke.py
```
```
{
  "churn_probability": 0.6638167617162171,
  "churn": true
}
```