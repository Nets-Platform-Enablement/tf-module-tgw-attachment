# tf-module-tgw-attachment
Terraform module for creating needed AWS resources for attaching given subnet(s) to a given Transit Gateway.

## Variables

| Name              | Description                                      | Type         | Default | Sensitive |
|-------------------|--------------------------------------------------|--------------|---------|-----------|
| `vpc_id`          | VPC ID                                           | `string`     | n/a     | no        |
| `amazon_side_asn` | ASN of the transit gateway to attach to          | `number`     | n/a     | no        |
| `subnet_ids`      | List of subnet IDs to attach transit gateway     | `list(string)` | n/a   | no        |
| `tgw_routes`      | List of CIDR blocks to route via TGW             | `set(string)` | `[]`   | no        |
| `tags`            | Map of tags to attach to resources               | `map(string)` | `{}`   | no        |

## Examples

```
module "onprem_transitgw" {
  source = "git::https://github.com/Nets-Platform-Enablement/tf-module-tgw-attachment?ref=v0.1.0"
  vpc_id      = "vpc-123456789abcdef"
  subnet_ids  = [
    "subnet-abcdefg0123456789",
    "subnet-987654321gfedcba0",
  ]
  tgw_routes  = [
    "172.16.0.0/12",
    "172.31.0.0/16",
  ]
  tags        = {
    Environment: "test"
  }
}
```
