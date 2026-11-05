# Outputs for customer360_kafka_to_postgresql pipeline

output "namespace" {
  description = "Kubernetes namespace where pipeline is deployed"
  value       = kubernetes_namespace.pipelines.metadata[0].name
}

output "spark_application_name" {
  description = "SparkApplication resource name"
  value       = "customer360-kafka-to-postgresql"
}

output "service_account" {
  description = "Spark service account name"
  value       = kubernetes_service_account.spark.metadata[0].name
}

output "cron_schedule" {
  description = "Pipeline schedule"
  value       = "0 2 * * *"
}
