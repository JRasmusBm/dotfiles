local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("terraform", {
  s(
    { trig = "ec2", name = "ec2" },
    fmt(
      [[
data "aws_ami" "ubuntu" {{
  most_recent = true

    filter {{
      name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }}

  filter {{
    name   = "virtualization-type"
      values = ["hvm"]
  }}

  owners = ["099720109477"] # Canonical
}}

resource "aws_instance" "{}" {{
  ami             = data.aws_ami.ubuntu.id
    subnet_id       = aws_subnet.{}.id
    security_groups = ["${{aws_security_group.{}.id}}"]
    instance_type   = "t2.micro"
    tags = {{
      project = "{}"
    }}
  key_name = "{}"
}}
  ]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "vpc", name = "vpc" },
    fmt(
      [[
resource "aws_vpc" "{}" {{
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}}
  
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ip", name = "elastic ip" },
    fmt(
      [[
resource "aws_eip" "ip-{}" {{
  instance = aws_instance.{}.id
  vpc      = true
}}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "subnet", name = "subnet" },
    fmt(
      [[
resource "aws_subnet" "{}" {{
  cidr_block        = cidrsubnet(aws_vpc.{}.cidr_block, 3, 1)
    vpc_id            = aws_vpc.{}.id
    availability_zone = var.availability-zone
}}

resource "aws_route_table" "{}" {{
  vpc_id = aws_vpc.{}.id
  route {{
    cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.{}.id
  }}
}}

resource "aws_route_table_association" "{}" {{
  subnet_id      = aws_subnet.{}.id
  route_table_id = aws_route_table.{}.id
}}
  ]],
      { i(1), i(2), rep(2), i(3), rep(2), i(4), i(5), rep(1), rep(3) }
    )
  ),

  s(
    { trig = "gw", name = "gateway" },
    fmt(
      [[
resource "aws_internet_gateway" "{}" {{
  vpc_id = "${{aws_vpc.{}.id}}"
}}
  
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "sec", name = "securtiy" },
    fmt(
      [[
resource "aws_security_group" "{}" {{
  name   = "{}"
  vpc_id = aws_vpc.{}.id

  ingress {{
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }}

  // Terraform removes the default rule
  egress {{
    from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }}
}}
 
{}
  ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "ec2!", name = "full ec2" },
    fmt(
      [[
resource "aws_vpc" "{}" {{
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}}

resource "aws_subnet" "{}" {{
  cidr_block        = cidrsubnet(aws_vpc.{}.cidr_block, 3, 1)
    vpc_id            = aws_vpc.{}.id
    availability_zone = var.availability-zone
}}

resource "aws_internet_gateway" "{}" {{
  vpc_id = "${{aws_vpc.{}.id}}"
}}

resource "aws_route_table" "{}" {{
  vpc_id = aws_vpc.{}.id
  route {{
    cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.{}.id
  }}
}}

resource "aws_route_table_association" "{}" {{
  subnet_id      = aws_subnet.{}.id
  route_table_id = aws_route_table.{}.id
}}

resource "aws_security_group" "{}" {{
  name   = "{}"
  vpc_id = aws_vpc.{}.id

  ingress {{
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }}

  // Terraform removes the default rule
  egress {{
    from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }}
}}

data "aws_ami" "ubuntu" {{
  most_recent = true

    filter {{
      name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }}

  filter {{
    name   = "virtualization-type"
      values = ["hvm"]
  }}

  owners = ["099720109477"] # Canonical
}}

resource "aws_instance" "{}" {{
  ami             = data.aws_ami.ubuntu.id
    subnet_id       = aws_subnet.{}.id
    security_groups = ["${{aws_security_group.{}.id}}"]
    instance_type   = "t2.micro"
  key_name = "{}"
}}

resource "aws_eip" "{}" {{
  instance = aws_instance.{}.id
  vpc      = true
}}
  ]],
      {
        i(1), -- vpc
        i(2), -- subnet
        rep(1),
        rep(1),
        i(3), -- gateway
        rep(1),
        i(4), -- route table
        rep(1),
        rep(3),
        i(5), -- route table association
        rep(2),
        rep(4),
        i(6), -- security group
        i(7), -- security group name
        rep(1),
        i(8), -- instance
        rep(2),
        rep(6),
        i(9), -- secret key name
        i(10), -- elastic ip
        rep(8),
      }
    )
  ),

  s(
    { trig = "vd", name = "variable declaration" },
    fmt(
      [[
variable "{}" {{
  default = "{}"
}}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),
})
