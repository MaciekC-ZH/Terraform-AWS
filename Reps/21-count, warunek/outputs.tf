output "alarm_arn" {
  value = length(aws_cloudwatch_metric_alarm.cpu_alarm) > 0 ? aws_cloudwatch_metric_alarm.cpu_alarm[0].arn : "Brak aktywnego monitoringu"
}
