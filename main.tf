#
# TGW VPC attachment
#
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = data.aws_ec2_transit_gateway.target.id
  vpc_id             = var.vpc_id

  tags = var.tags
}

data "aws_ec2_transit_gateway" "target" {
  filter {
    name   = "options.amazon-side-asn"
    values = [var.amazon_side_asn]
  }
}

# Query route table(s) from given subnets
data "aws_route_table" "source" {
  for_each = toset(var.subnet_ids)
  subnet_id = each.value
}

locals {
  # Unique Route Table IDs from given subnets
  route_tables = toset([for nw in data.aws_route_table.source : nw.route_table_id ])
  # Unique route_table - subnet -pairs
  route_to_subnets = setproduct(
    local.route_tables,
    var.tgw_routes
  )
  # {
  #   "<route-table>:<cidr>" : {
  #     route_table_id: <route-table>,
  #     cidr: <cidr>
  #   },
  #   ...
  # }
  routes = {
    for pair in local.route_to_subnets : "${pair[0]}:${pair[1]}" => {
      "route_table_id": pair[0],
      "cidr": pair[1]
    }
  }
}

resource "aws_route" "to_tgw" {
  for_each                = local.routes
  transit_gateway_id      = data.aws_ec2_transit_gateway.target.id
  route_table_id          = each.value.route_table_id
  destination_cidr_block  = each.value.cidr

  depends_on = [ aws_ec2_transit_gateway_vpc_attachment.this ]
}
