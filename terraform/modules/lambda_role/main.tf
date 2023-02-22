/**
*   IAM Role
*   
*   Creates an IAM role that can be associated with a lambda function
*
*   Default tags applied
*/

resource "aws_iam_role" "lambda_role" {

  name = local.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  inline_policy {
    name   = "${local.role_name}-policy"
    policy = var.policy
  }

  tags = merge(
    local.default_tags,
    {
      application = var.application
      environment = var.environment
    }
  )
}