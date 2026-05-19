output "grafana_url" {
  value = "http://${var.server_host}:3000"
}

output "prometheus_url" {
  value = "http://${var.server_host}:9090"
}

output "alertmanager_url" {
  value = "http://${var.server_host}:9093"
}

output "demo_app_url" {
  value = "http://${var.server_host}:8080"
}