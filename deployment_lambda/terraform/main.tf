terraform {
    required_version = ">=1.0"
    backend "s3" {
        bucket = "tf-state-churnprediction"
        key = "mlops-stg.tfstate
        region = us-east-1
        encrypt = true
    }
}

provider "aws" {
    region =  var.aws_region
}

#ecr repository
resource "aws_ecr_repository" "model_repo" {
    name = "${var.project_name}-${var.environment}"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
}

# iam role
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-lambda-role"
    Environment = var.environment
  }
}

# IAM Policy Attachment for Lambda Basic Execution
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

#lambda function
resource "aws_lambda_function" "model_lambda" {
  function_name = "${var.project_name}-${var.environment}"
  role         = aws_iam_role.lambda_role.arn
  image_uri    = "${aws_ecr_repository.model_repo.repository_url}:latest"
  package_type = "Image"
  timeout     = 300  # 5 minutes
  memory_size = 1024
  environment {
    variables = {
      ENVIRONMENT = var.environment
      MODEL_NAME  = var.project_name
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = {
    Name        = "${var.project_name}-lambda"
    Environment = var.environment
  }
}
#cloudwatch 
# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-${var.environment}"
  retention_in_days = 7

  tags = {
    Name        = "${var.project_name}-logs"
    Environment = var.environment
  }
}

# Outputs
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.model_repo.repository_url
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.model_lambda.function_name
}
  
