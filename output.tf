output "routes" {
  value = local.routes
  description = "Route-table - subnet pairs added"
}

output "tgw_routes" {
  value = var.tgw_routes
}

output "transit_gateway_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.id
  description = "Transit Gateway Attachment ID"
}

output "transit_gateway_id" {
  value =  data.aws_ec2_transit_gateway.target.id
  description = "Transit Gateway ID"
}
