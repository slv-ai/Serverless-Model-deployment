# Serverless-Model-deployment
Model deployment with AWS Lambda serverless

1. turn the starter notebook into script using:
```
jupyter nbconvert --to=script starter.ipynb
mv starter.py train.py
```
2. install dependencies
```
pip install requests fastapi uvicorn
```
3. run python predict.py
FastAPI generates OpenAPI docs automatically at /docs
```
http://localhost:9696/docs
```
input and output validation in fastapi
4. 
