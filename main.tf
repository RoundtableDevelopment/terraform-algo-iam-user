provider "aws" {
  profile = "${var.aws_profile}"
}

#########
#  IAM  #
#########

resource "aws_iam_user" "algo-user" {
  name = "${var.iam_user_name}"
}

resource "aws_iam_access_key" "algo-user" {
  user = "${aws_iam_user.algo-user.name}"
}

resource "aws_iam_user_policy" "algo-provisioning" {
  name = "AlgoVPN_Provisioning"
  user = "${aws_iam_user.algo-user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PreDeployment",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeImages",
        "ec2:DescribeKeyPairs",
        "ec2:ImportKeyPair"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "DeployCloudFormationStack",
      "Effect": "Allow",
      "Action": [
        "cloudformation:CreateStack",
        "cloudformation:UpdateStack",
        "cloudformation:DescribeStacks",
        "cloudformation:DescribeStackEvents",
        "cloudformation:ListStackResources"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "CloudFormationEC2Access",
      "Effect": "Allow",
      "Action": [
        "ec2:CreateInternetGateway",
        "ec2:DescribeVpcs",
        "ec2:CreateVpc",
        "ec2:DescribeInternetGateways",
        "ec2:ModifyVpcAttribute",
        "ec2:createTags",
        "ec2:CreateSubnet",
        "ec2:Associate*",
        "ec2:CreateRouteTable",
        "ec2:AttachInternetGateway",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSubnets",
        "ec2:ModifySubnetAttribute",
        "ec2:CreateRoute",
        "ec2:CreateSecurityGroup",
        "ec2:DescribeSecurityGroups",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RunInstances",
        "ec2:DescribeInstances",
        "ec2:AllocateAddress",
        "ec2:DescribeAddresses"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}