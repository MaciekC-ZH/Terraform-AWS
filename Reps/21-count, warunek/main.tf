resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  count               = var.enable_monitoring ? 1 : 0
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
}
