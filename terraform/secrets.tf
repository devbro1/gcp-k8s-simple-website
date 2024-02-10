data "google_client_config" "default" {
}

provider "kubernetes" {
  host             = "https://${google_container_cluster.primary.endpoint}"
  token            = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  )
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }

  depends_on = [google_container_node_pool.primary_nodes]
}

resource "random_password" "db_password" {
  length = 16
}

resource "kubernetes_secret" "db_secrets" {
  metadata {
    name      = "db-credentials"
    namespace = data.kubernetes_namespace.default.metadata[0].name
  }

  data = {
    username = "dbuser1"
    password = random_password.db_password.result
    url = "postgresql+psycopg2://dbuser1:${urlencode(random_password.db_password.result)}@postgres-main/tododb"
    url_replica = "postgresql+psycopg2://dbuser1:${urlencode(random_password.db_password.result)}@postgres-replica/tododb"
  }
}