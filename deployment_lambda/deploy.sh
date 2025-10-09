IMAGE_NAME ="churn-prediction-lambda"
AWS_REGION = "us-east-1"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r ".Account")

# Get latest commit SHA and current datetime
COMMIT_SHA=$(git rev-parse --short HEAD)
DATETIME=$(date +"%Y%m%d-%H%M%S")
IMAGE_TAG="${COMMIT_SHA}-${DATETIME}"

ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
IMAGE_URI="${ECR_URI}/${IMAGE_NAME}:${IMAGE_TAG}"

#LOGIN TO ECR
aws ecr get-login-password \
    --region ${AWS_REGION} | docker login \
    --username AWS \
    --password-stdin ${ECR_URI}

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_URI}
docker push ${IMAGE_URI}
echo "Image pushed to ECR successfully"