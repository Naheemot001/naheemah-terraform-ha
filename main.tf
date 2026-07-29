resource "aws_launch_template" "naheemah_ha_lt" {
    name_prefix = "naheemah-ha-"
    image_id = var.ami
    instance_type   = var.instance_type
    network_interfaces {
      associate_public_ip_address = true
      security_groups = [ aws_security_group.naheemah_ha_sg.id ]
    }
    user_data = filebase64("userdata.sh")
    key_name = var.key_name
}

resource "aws_autoscaling_group" "naheemah_ha_asg" {
  name_prefix         = "terraform-asg-"
  min_size            = 3
  max_size            = 6
  desired_capacity    = 3
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.naheemah_ha_lt.id
    version = "$Latest"
  }


  health_check_type         = "EC2"
  health_check_grace_period = 300
  tag {
    key                 = "Name"
    value               = "naheemah-ha"
    propagate_at_launch = true
  }
}

