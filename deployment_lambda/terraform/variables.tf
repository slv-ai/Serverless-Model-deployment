variable "aws_region {
    description = "aws region"
    type = string
    default = us-east-1
}

variable "project_name" {
    description = "name of project"
    default = "churnprediction_model"
}

variable "environment" {
    description = "dev ,staging, prod "
    default = "dev"
}