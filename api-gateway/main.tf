resource "aws_api_gateway_rest_api" "testAPI" {
  name = "test API"
  description = "tf test API"
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
}

resource "aws_api_gateway_resource" "testResource" {
  rest_api_id = aws_api_gateway_rest_api.testAPI.id
  parent_id = aws_api_gateway_rest_api.testAPI.root_resource_id
  path_part = "testresource"
}

resource "aws_api_gateway_deployment" "testDeployment" {
  rest_api_id = aws_api_gateway_rest_api.testAPI.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.testAPI.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "testStage" {
  deployment_id = aws_api_gateway_deployment.testDeployment.id
  rest_api_id = aws_api_gateway_rest_api.testAPI.id
  stage_name = "testStage"
}