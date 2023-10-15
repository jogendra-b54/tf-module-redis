# resource "aws_security_group" "allows_docdb" {
#   name        = "roboshop allows_docdb_internal only"
#   description = "allows_docdb_internal only"
#   vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

#   ingress {
#     description = "docdb from VPC"
#     from_port   = 27017
#     to_port     = 27017
#     protocol    = "tcp"
#     cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]     
#   } 

#    ingress {
#     description = "docdb from Default VPC"
#     from_port   = 27017
#     to_port     = 27017
#     protocol    = "tcp"
#     cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]     
#   } 

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   } 

#   tags = {
#     Name = "roboshop-${var.ENV}-docdb-sg"
#   }
# }