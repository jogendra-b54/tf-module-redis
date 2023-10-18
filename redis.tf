# providing Elastic Cache Cluster : Redis

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  engine_version       = "6.x"
  port                 = 6379
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.allows_redis.id]
}

# Creates parameter Group needed for Elastic cache
resource "aws_elasticache_parameter_group" "redis_pg" {
    name = "roboshop-${var.ENV}-redis-pg"
    family = "redis6.x"
}

# creates subnet group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "roboshop-redis-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
     Name = "roboshop-redis-${var.ENV}-subnetgroup"
  }
}

# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   skip_final_snapshot     = true

#   vpc_security_group_ids  =  [aws_security_group.allows_docdb.id]
#   db_subnet_group_name    =  aws_docdb_subnet_group.docdb_subnet_group.name
# }

# in which VPC , in which subnet it has to be created is not mentioned


# creates subnet group
# resource "aws_docdb_subnet_group" "docdb_subnet_group" {
#   name                = "roboshop-docdb-${var.ENV}-subnetgroup"
#   subnet_ids          =  data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS 

#   tags = {
#     Name = "roboshop-docdb-${var.ENV}-subnetgroup"
#   }
# } 

# Creates Compute Machines needed for DocumentDB and these has to be attached to the cluster
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}-docdb-instance"
#   cluster_identifier = aws_docdb_cluster.docdb.id      # this argument attaches the nodes created here to the docdb cluster
#   instance_class     = "db.t3.medium"
#   depends_on = [ aws_docdb_cluster.docdb ]
# }