terraform {
  required_providers {
    null = { source = "hashicorp/null", version = "~> 3.0" }
  }
}

resource "null_resource" "install_observability_stack" {
  triggers = {
    always_run = timestamp()
  }

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = file("~/.ssh/id_ed25519")
    host        = var.server_host
  }

  provisioner "file" {
    source      = "/home/cybernerd/observeX"
    destination = "/home/admin/observeX"
  }

  provisioner "remote-exec" {
    inline = [
      "ln -sf /home/admin/observeX/app /home/admin/observeX/demo-app",
      "chmod +x /home/admin/observeX/terraform/scripts/install.sh",
      "sudo GRAFANA_ADMIN_PASSWORD='${var.grafana_admin_password}' SLACK_WEBHOOK_URL='${var.slack_webhook_url}' SERVER_HOST='${var.server_host}' bash /home/admin/observeX/terraform/scripts/install.sh 2>&1 | tee /var/log/observability-install.log"
    ]
  }
}