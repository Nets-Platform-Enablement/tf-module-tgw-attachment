variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "name" {
  description = "Name tag for the transit gateway attachment"
  type = string
  sensitive = false
  default = ""
}

variable "amazon_side_asn" {
  type = number
  description = "ASN of the transit gateway to attach to"
  sensitive = false
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach transit gateway"
  type = list(string)
  sensitive = false
}

variable "tgw_routes" {
  description = "List of CIDR blocks to route via TGW"
  type        = set(string)
  default = [ ]
  sensitive = false
}

variable "tags" {
  description = "Map of tags to attach to resources"
  type = map(string)
  sensitive = false
  default = { }
}
