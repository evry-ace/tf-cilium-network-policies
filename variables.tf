# Default variables
variable "default_cilium_network_policies_enabled" {
  description = "Define whether or not the Cilium Network Policies should be created."
  type        = bool
  default     = false
}

variable "namespace" {
  description = "The Kubernetes namespace where the resource(s) will be created"
  type        = string
}

