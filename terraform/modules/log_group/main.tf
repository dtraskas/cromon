/**
*   Log group
*   
*   Creates a log group that can be associated with an AWS resource
*
*   Default tags applied
*/

resource "aws_cloudwatch_log_group" "logz" {

  tags = merge(
    local.default_tags,
    {
      application = var.application
    }
  )
}