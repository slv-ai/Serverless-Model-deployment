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
