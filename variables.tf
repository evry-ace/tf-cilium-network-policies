# Default variables
variable "enable_dns_visibility" {
  description = "Define whether or not the Cilium Network Policies for DNS visibility should be created."
  type        = bool
  default     = false
}

variable "dns_namespaces" {
  description = "The Kubernetes namespace(s) where the resource(s) will be created. If omitted, or set to empty, and enable_dns_visiblity is set to true, the policy will be created for all namespaces in the Kubernetes cluster."
  type        = list(string)
  default     = []
}
