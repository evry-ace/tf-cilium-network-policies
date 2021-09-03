data "kubernetes_all_namespaces" "all_namespaces" {}

locals {
  namespaces = length(var.dns_namespaces) == 0 ? data.kubernetes_all_namespaces.all_namespaces.namespaces : var.dns_namespaces

}

resource "kubernetes_manifest" "dns_visibility" {
  for_each = {
    for k in local.namespaces : k => k
    if var.enable_dns_visibility == true
  }

  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumNetworkPolicy"

    metadata = {
      name      = "dns-visibility-policy"
      namespace = each.value
    }

    spec = {
      egress = [
        {
          toEntities = [
            "cluster",
            "world",
          ]
        },
        {
          toEndpoints = [
            {
              matchLabels = {
                "io.kubernetes.pod.namespace" = "kube-system"
                "k8s-app"                     = "kube-dns"
              }
            },
          ]
          toPorts = [
            {
              ports = [
                {
                  port     = "53"
                  protocol = "ANY"
                },
              ]
              rules = {
                dns = [
                  {
                    matchPattern = "*"
                  },
                ]
              }
            },
          ]
        },
        {
          toFQDNs = [
            {
              matchPattern = "*"
            },
          ]
        },
      ]
      endpointSelector = {
        matchLabels = {}
      }
      ingress = [
        {
          fromEntities = [
            "world",
            "cluster",
          ]
        },
        {
          fromEndpoints = []
        },
      ]
    }
  }
}
