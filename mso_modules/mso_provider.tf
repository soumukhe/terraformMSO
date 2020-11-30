provider "mso" {
  username = var.creds.username
  password = var.creds.password
  url      = var.creds.url
  domain   = var.creds.domain
  insecure = "true"
}
