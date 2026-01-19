output "alb_arn" {
    description = "The ARN of the Application Load Balancer"
    value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.alb-group.arn
}