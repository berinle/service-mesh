variable "access_key" {
    type = string
}
variable "secret_key" {
    type = string
}

variable "cluster_arn" {
    type = string
}
variable "cluster_tag" {
    type = string
}
variable "cluster_name" {
    type = string
}

variable "ecs_service_role" {
    type = string
}

variable "service_arn" {
    type = string
}
variable "task_definition" {
    type = string
}
variable "lb_container_name" {
    type = string
}
variable "lb_target_group_arn" {
    type = string
}
variable "task_definition_id" {
    type = string
}
variable "alb_sg" {
    type = string
}
variable "subnet_id_1" {
    type = string
}
variable "subnet_id_2" {
    type = string
}