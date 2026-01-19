resource "aws_launch_template" "template" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  user_data = base64encode(
    file("${path.module}/user_data.sh")
  )

}

resource "aws_autoscaling_group" "autoscale" {
  name                 = var.autoscaling_name
  desired_capacity     = var.desired_capacity
  max_size             = var.max
  min_size             = var.min
  target_group_arns = [var.target_group_arn]
  health_check_type    = "ELB"
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier  = var.subnet_ids


  launch_template {
    id      = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }
}