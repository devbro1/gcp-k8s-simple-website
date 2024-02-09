resource "google_artifact_registry_repository" "todo-website" {
  repository_id = "todo-website"
  description   = "docker repository for todo-website images"
  format        = "DOCKER"
}