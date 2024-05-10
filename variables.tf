variable "project" {}

variable "region" {
  type = map(any)
}

variable "zones" {
  type = map(list(string))
}

variable "subnets" {
  type = map(any)
}

variable "foobar_configs" {
  type = map(any)
}
variable "foo_schedules" {
  type = map(any)
}

variable "foo-sa" {}

###
variable "ip_range_pods" {
  type = string
}

variable "ip_range_services" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "master_ip_range" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "subnet_pod_ip_range" {
  type = string
}

variable "subnet_svc_ip_range" {
  type = string
}
###