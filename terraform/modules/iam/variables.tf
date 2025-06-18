variable "user_name" {
  description = "Name of the IAM user"
  type        = string
}

variable "user_path" {
  description = "Path for the IAM user"
  type        = string
  default     = "/prod/"
}

variable "environment" {
  description = "Environment tag (e.g., production, staging)"
  type        = string
  default     = "production"
}

variable "purpose" {
  description = "Purpose tag for the IAM user"
  type        = string
  default     = "nomad-server"
}

variable "policy_actions" {
  description = "List of AWS actions to allow"
  type        = list(string)
  default     = [
    # IAM permissions for service-linked roles
    "iam:CreateServiceLinkedRole",
    "iam:GetRole",
    "iam:ListRoles",

    # Instance permissions
    "ec2:RunInstances",
    "ec2:StopInstances",
    "ec2:StartInstances",
    "ec2:TerminateInstances",
    "ec2:DescribeInstances",
    "ec2:DescribeSpotInstanceRequests",
    "ec2:RequestSpotInstances",
    "ec2:CancelSpotInstanceRequests",
    "ec2:DescribeImages",
    "ec2:CreateTags",

    # EBS Volume permissions
    "ec2:DescribeVolumes",
    "ec2:CreateVolume",
    "ec2:DeleteVolume",
    "ec2:AttachVolume",
    "ec2:DetachVolume",
    "ec2:DescribeVolumeStatus",
    "ec2:DescribeVolumeAttribute",
    "ec2:ModifyVolumeAttribute",

    # VPC permissions
    "ec2:DescribeVpcs",
    "ec2:CreateVpc",
    "ec2:DeleteVpc",
    "ec2:ModifyVpcAttribute",
    "ec2:DescribeVpcClassicLink",
    "ec2:DescribeVpcClassicLinkDnsSupport",
    "ec2:DescribeVpcAttribute",

    # Subnet permissions
    "ec2:CreateSubnet",
    "ec2:DeleteSubnet",
    "ec2:DescribeSubnets",
    "ec2:ModifySubnetAttribute",

    # Internet Gateway permissions
    "ec2:CreateInternetGateway",
    "ec2:DeleteInternetGateway",
    "ec2:AttachInternetGateway",
    "ec2:DetachInternetGateway",
    "ec2:DescribeInternetGateways",

    # Route Table permissions
    "ec2:CreateRouteTable",
    "ec2:DeleteRouteTable",
    "ec2:CreateRoute",
    "ec2:DeleteRoute",
    "ec2:AssociateRouteTable",
    "ec2:DisassociateRouteTable",
    "ec2:DescribeRouteTables",

    # Security Group permissions
    "ec2:DescribeSecurityGroups",
    "ec2:CreateSecurityGroup",
    "ec2:DeleteSecurityGroup",
    "ec2:AuthorizeSecurityGroupIngress",
    "ec2:RevokeSecurityGroupIngress",
    "ec2:AuthorizeSecurityGroupEgress",
    "ec2:RevokeSecurityGroupEgress",

    # Key Pair permissions
    "ec2:DescribeKeyPairs",
    "ec2:CreateKeyPair",
    "ec2:DeleteKeyPair",
    "ec2:ImportKeyPair",

    # SQS permissions
    "sqs:ReceiveMessage",
    "sqs:DeleteMessage",
    "sqs:GetQueueAttributes",
    "sqs:GetQueueUrl",
    "sqs:ListQueues",

    # S3 permissions
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",

    # SSM Parameter Store permissions
    "ssm:GetParameters",
    "ssm:GetParameter",
    "ssm:GetParametersByPath",
    "ssm:DescribeParameters",

    # KMS permissions
    "kms:Decrypt",
    "kms:DescribeKey",
    "kms:GenerateDataKey"
  ]
} 