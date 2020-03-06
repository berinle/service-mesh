provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  access_key = "var.access_key"
  secret_key = "var.secret_key"
}

resource "aws_ecs_cluster" "cluster01" {
    arn                = "var.cluster_arn"
    capacity_providers = []
    id                 = "var.cluster_arn"
    name               = "var.cluster_name"
    tags               = {
        "name" = "var.cluster_tag"
    }

    setting {
        name  = "containerInsights"
        value = "disabled"
    }
}

resource "aws_ecs_cluster" "default" {
}

# aws_ecs_task_definition.kuma-cp
resource "aws_ecs_task_definition" "kuma-cp" {
    container_definitions    = file("task-definitions/kuma-cp.json")
    cpu                      = "1024"
    family                   = "var.task_definition_id"
    id                       = "var.task_definition_id"
    memory                   = "256"
    requires_compatibilities = [
        "EC2",
    ]
    tags                     = {
        "name" = "var.task_definition_id"
    }
}

resource "aws_ecs_service" "kuma-svc" {
    cluster                            = "var.cluster_arn"
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 100
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    iam_role                           = "var.ecs_service_role"
    id                                 = "var.service_arn"
    launch_type                        = "EC2"
    name                               = "var.service_name"
    propagate_tags                     = "NONE"
    scheduling_strategy                = "REPLICA"
    tags                               = {}
    task_definition                    = "var.task_definition"

    deployment_controller {
        type = "ECS"
    }

    load_balancer {
        container_name   = "var.container_name"
        container_port   = 5681
        target_group_arn = "var.lb_target_group_arn"
    }

    ordered_placement_strategy {
        field = "attribute:ecs.availability-zone"
        type  = "spread"
    }
    ordered_placement_strategy {
        field = "instanceId"
        type  = "spread"
    }
}

resource "aws_lb" "kuma-alb" {
    name                       = "kuma-alb"
    enable_deletion_protection = false
    enable_http2               = true
    idle_timeout               = 60
    internal                   = false
    ip_address_type            = "ipv4"
    load_balancer_type         = "application"
    # default security group (optional)
    # security_groups            = [
    #     "sg-089ed6c3979c54942",
    # ]
    subnets                    = ["var.alb_sg"]
    tags                       = {
        "name" = "kuma-alb"
    }
    vpc_id                     = "var.vpc_id"
    access_logs {
        enabled = false
    }

    subnet_mapping {
        subnet_id = "var.subnet_id_1"
    }
    subnet_mapping {
        subnet_id = "var.subnet_id_2"
    }

    timeouts {}
}

resource "aws_iam_role" "ecsServiceRole" {
    assume_role_policy    = file("iam-definitions/ecs-role.json")
    force_detach_policies = false
    id                    = "ecsServiceRole"
    max_session_duration  = 3600
    name                  = "ecsServiceRole"
    path                  = "/"
    tags                  = {}
}

resource "aws_iam_role" "ecsInstanceRole" {
    assume_role_policy    = file("iam-definitions/ecs-instance-role.json")
    force_detach_policies = false
    id                    = "ecsInstanceRole"
    max_session_duration  = 3600
    name                  = "ecsInstanceRole"
    path                  = "/"
    tags                  = {}
}