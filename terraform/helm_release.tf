# Uncomment lines 3-17 if you intend to use terraform.tfvars

# variable "host" {
#   type = string
# }
 
# variable "client_certificate" {
#   type = string
# }
 
# variable "client_key" {
#   type = string
# }
 
# variable "cluster_ca_certificate" {
#   type = string
# }

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"

    # Uncomment below values if you are using a remote kubernetes cluster and specify cluster information accordingly

    # host                   = var.host
    # client_certificate     = base64decode(var.client_certificate)
    # client_key             = base64decode(var.client_key)
    # cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "mlapi" {
  name       = "mlapi"
  chart      = ".././charts"

}
