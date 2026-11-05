# Variables for customer360_kafka_to_postgresql pipeline infrastructure

variable "namespace" {
  description = "Kubernetes namespace for the pipeline"
  type        = string
  default     = "data-pipelines"
}

variable "kube_context" {
  description = "Kubernetes context to use"
  type        = string
  default     = "production"
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "tf_state_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "pipeline_version" {
  description = "Pipeline image version tag"
  type        = string
  default     = "latest"
}

variable "spark_image" {
  description = "Docker image for the Spark pipeline"
  type        = string
  default     = "your-registry/customer360-kafka-to-postgresql:latest"
}

variable "executor_cores" {
  description = "Number of cores per Spark executor"
  type        = number
  default     = 2
}

variable "executor_instances" {
  description = "Number of Spark executor instances"
  type        = number
  default     = 2
}

variable "executor_memory" {
  description = "Memory per Spark executor"
  type        = string
  default     = "2g"
}

variable "source_host" { description = "Source DB host" type = string }
variable "source_port" { description = "Source DB port" type = string default = "5432" }
variable "source_db" { description = "Source database name" type = string }
variable "source_user" { description = "Source DB user" type = string }
variable "source_password" { description = "Source DB password" type = string sensitive = true }
variable "sink_host" { description = "Sink DB host" type = string }
variable "sink_password" { description = "Sink DB password" type = string sensitive = true }



variable "kafka_brokers" { description = "Kafka broker addresses (comma-separated)" type = string }
