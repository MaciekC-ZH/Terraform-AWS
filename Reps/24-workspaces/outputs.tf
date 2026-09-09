output "configured_threshold" {
  value = "Alarm dla workspace ${terraform.workspace} ustawiony na ${aws_cloudwatch_metric_alarm.cpu_high.threshold}%"
}
