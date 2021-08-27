resource "kubernetes_manifest" "dns_visibility" {
  count = var.default_cilium_network_policies_enabled ? 1 : 0

  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumNetworkPolicy"

    metadata = {
      name      = "dns-visibility-policy"
      namespace = var.namespace
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
