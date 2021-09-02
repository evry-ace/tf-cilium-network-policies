data "kubernetes_all_namespaces" "all_namespaces" {}

locals {
  namespace = length(var.dns_namespace) == 0 ? data.kubernetes_all_namespaces.all_namespaces : var.dns_namespace

  ns_map = zipmap(var.enable_dns_visibility ? ["true"] : ["false"], local.namespace)

}

resource "kubernetes_manifest" "dns_visibility" {
  for_each = {
    for k, v in local.ns_map : k => v
    if k == "true"
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
