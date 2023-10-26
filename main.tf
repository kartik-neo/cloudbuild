provider "google" {
    project = "Project Name"
    region = "us-central1"
}
resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv-cicd"
  location = "asia-south-1"
  template {
    spec {
      containers {
        image = "asia-south1-docker.pkg.dev/kartik69/test:${var.tags}"
        ports {
          container_port = 80
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
variable "tags" {
  type= string   
}  
