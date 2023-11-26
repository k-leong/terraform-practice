terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "file_zip" {
  type = "zip"
  source_file = "hello-python.py"
  output_path = "hello-python.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename = "hello-python.zip"
  function_name = "hello_world"
  role = aws_iam_role.iam_for_lambda.arn

  handler = "hello-python.lambda_handler"
  runtime = "python3.11"
}