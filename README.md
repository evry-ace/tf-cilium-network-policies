# Cilium network policies module

A Terraform module for implementing Cilium Network Policies

## Documentation

### Technical description of module

In order to use this module, you need to use the Terraform *kubernetes* provider in a version higher than, or equal to, version `2.4.1`. In addition, Terraform must be of version `0.13` or above.

An additional requirement is that the **Beta** feature `kubernetes_manifest` is enabled for the *kubernetes* provider:

```terraform
provider "kubernetes" {
    ....

    experiments {
        manifest_resource = true
    }
}
```

To upgrade from the *kubernetes_alpha* provider, to using the **Beta** channel of the *kubernetes* provider, you can follow the instructions as provided here:
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/alpha-manifest-migration-guide

## How to use this module

Create a module in your Terraform repository, and pin a release (for example) like this:

```terraform
module "cilium_network_policies" {
  source = "github.com/evry-ace/tf-cilium-network-policies.git?ref=vX.Y.Z"

  parameter(s) = value

}
```

And you should be off to the races :)

### Create DNS visibility network policies

You can create a DNS visibility network policy for individual namespaces, or for all namespaces in your Kubernetes cluster. If you set `enable_dns_visibility` to `true`, the deciding factor is whether or not the `dns_namespace` parameter is assigned any value.

If `dns_namespace` is omitted, or set like `dns_namespace = ""`, a DNS visibility network policy will be created in all namespaces in your Kubernetes cluster.

*Example, creating in all namespaces*

```terraform
...

  enable_dns_visibility = true

}
```

If `dns_namspace` is set, the network policy will only be created for the defined value.

*Example, create for one or more namespaces*

```terraform
...

  enable_dns_visibility = true
  dns_namespace         = ["namespace1", "namespace2",]

}
```

## Module idiosyncrasies

*None*

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | >= 0.13 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.dns_visibility](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns_visibility"></a> [enable\_dns\_visiblity](#input\_enable\_dns\_visibility) | Define whether or not the DNS visibility Cilium network policy should be created. | `bool` | `false` | no |
| <a name="input_dns_namespace"></a> [dns\_namspace](#input\_dns\_namspace) | Name of the Kubernetes namespace(s) to install the Cilium Network Policies in | `list(string)` | `[]`] | yes |

## Outputs

No outputs.
