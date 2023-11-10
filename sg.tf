resource "aws_security_group" "allows_redis" {
  name        = "roboshop allows_redis_internal only"
  description = "allows_redis_internal only"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "redis from VPC"
    from_port   = var.REDIS_PORT_NUMBER
    to_port     = var.REDIS_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]     
  } 

   ingress {
    description = "redis from Default VPC"
    from_port   = var.REDIS_PORT_NUMBER
    to_port     = var.REDIS_PORT_NUMBER
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]     
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    Name = "roboshop-${var.ENV}-redis-sg"
  }
}




