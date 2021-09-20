provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

/*
resource "helm_release" "nginx" {
  name = "nginx-web-servere"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "9.5.4"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "replicaCount"
    value = "1"
  }
}
*/
resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.1"
  values     = ["${file("values.yaml")}"]
}


/*
resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
*/
