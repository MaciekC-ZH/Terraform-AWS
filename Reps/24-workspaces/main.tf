locals {
  cpu_thressholds = {
    dev  = 85
    prod = 60
  }
  alarm_actions_enabled = {
    dev  = false
    prod = true
  }
}
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "app-cpu-alarm-${terraform.workspace}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = lookup(local.cpu_thressholds, terraform.workspace, 80)
  actions_enabled     = lookup(local.alarm_actions_enabled, terraform.workspace, false)
}
