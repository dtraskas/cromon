resource "aws_iam_role" "lambda_role" {

  name = "${var.account_name}-${var.application}-${var.name_suffix}"

  tags = merge(
    local.default_tags,
    {
      Application = var.application
    }
  )

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
    name   = lambda_role.name
    policy = var.policy
  }

}