resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.family
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
  cluster        = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count  = var.desired_count
  launch_type    = "FARGATE"
  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}
