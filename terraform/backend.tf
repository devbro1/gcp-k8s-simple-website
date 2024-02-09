terraform {
  backend "gcs" {
    bucket  = "tf-states-devbro"
    prefix  = "terraform/state"
  }
}