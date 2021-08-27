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
| <a name="input_default_cilium_network_policies_enabled"></a> [default\_cilium\_network\_policies\_enabled](#input\_default\_cilium\_network\_policies\_enabled) | Define whether or not the Cilium network policies should be created. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the Kubernetes namespace to install the Cilium Network Policies in | `string` | n/a | yes |

## Outputs

No outputs.
