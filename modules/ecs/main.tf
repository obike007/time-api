resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.service
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  container_definitions    = jsonencode([
    {
      name      = "time-api",
      image     = var.image_url,
      portMappings = [{ containerPort = 5000, hostPort = 5000 }]
    }
  ])
}

resource "aws_ecs_service" "main" {
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration "aws_ecs_net_conf" {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = { Name = "ecs-vpc" }
}

resource "aws_subnet" "public" {
  count = var.public_subnets_count
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "main" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = var.subnets
}

resource "aws_lb_target_group" "main" {
  name     = "ecs-targets"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
