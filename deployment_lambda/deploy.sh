IMAGE_NAME ="churn_prediction_lambda"
ECR_URl =
REPO_URL =${ECR_URL}/churn_prediction_lambda
AWS_REGION = "us-east-1"
REMOTE_IMAGE_TAG = "${ECR_URL}/churn_prediction_lambda:v1"

#LOGIN TO ECR
aws ecr get-login-password \
    --region ${AWS_REGION} | docker login \
    --username AWS \
    --password-stdin ${ECR_URL}

docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REMOTE_IMAGE_TAG}
docker push ${REMOTE_IMAGE_TAG}
echo "Image pushed to ECR successfully"