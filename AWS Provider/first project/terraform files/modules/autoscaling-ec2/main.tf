resource "aws_launch_template" "template" {
  name_prefix     = var.name_prefix
  image_id        = var.image_id
  instance_type   = var.instance_type
}

resource "aws_autoscaling_group" "autoscale" {
  name                = var.autoscaling_name
  desired_capacity    = var.desired_capacity
  max_size            = var.max
  min_size            = var.min
  health_check_type   = "EC2"
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }
}