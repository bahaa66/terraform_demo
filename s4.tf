terraform {
  backend "s3" {
    bucket = "bahaabucket"
    key    = "path/to/my/key"
    region = "us-east-2"
  }
}
