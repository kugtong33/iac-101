# IaC Demo

This project is for demoing how to provision an AWS EC2 instance. The setup has the minimum requirements for a server that is both usable and accessible. You can connect to the instance using SSH and web services using port 80 and 443.

## Installation

In order to use this sample setup, you will need to install the following tools.

* Install [tfenv](https://github.com/tfutils/tfenv) for easier terraform version management.

  Go into the official repository and follow the installation instructions, you should be able to use the command afterwards.

  ```shell
  ❯ tfenv
  tfenv 2.0.0-37-g0494129
  Usage: tfenv <command> [<options>]

  Commands:
    install       Install a specific version of Terraform
    use           Switch a version to use
    uninstall     Uninstall a specific version of Terraform
    list          List all installed versions
    list-remote   List all installable versions
  ```

* Install latest terraform version, version 13 and up.

  Version 13 and up has new features that you might not be familiar if you had used v12 and below, check the official migration document for more information.

  ```shell
  ❯ tfenv install 0.14.9
  Installing Terraform v0.14.9
  Downloading release tarball from https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_linux_amd64.zip
  Downloading SHA hash file from https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_SHA256SUMS
  No keybase install found, skipping OpenPGP signature verification
  Archive:  tfenv_download.pizBai/terraform_0.14.9_linux_amd64.zip
    inflating: /home/megamoth/.tfenv/versions/0.14.9/terraform  
  Installation of terraform v0.14.9 successful. To make this your default version, run 'tfenv use 0.14.9'

  ❯ tfenv use 0.14.9
  Switching default version to v0.14.9
  Switching completed
  ```

* Install AWS CLI v2 using this guide, [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

  If the installation went smoothly, you should see this output with using the command for the first time.

    ```shell
    ❯ aws
    usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
    To see help text, you can run:

    aws help
    aws <command> help
    aws <command> <subcommand> help
    aws: error: too few arguments
    ```

* Setup your assigned AWS credentials.

  Since our infrastructure is in AWS this needed for us to be able to apply terraform definitions into the infrastructure.

  There will be designated developers that has access and not everyone can apply updates.

  ```shell
  ❯ aws configure
  AWS Access Key ID []: ****************
  AWS Secret Access Key []: ****************
  Default region name []: api-east-1
  Default output format []: json
  ```

* Test out terraform setup.

  Run initialize command and see if it has no issues.

  ```shell
  ❯ terraform init
  Initializing modules...

  Initializing the backend...

  Initializing provider plugins...
  - Using previously-installed hashicorp/template v2.1.2
  - Using previously-installed hashicorp/aws v2.70.0

  ...

  Terraform has been successfully initialized!
  ```

* Create the terraform S3 bucket.

  Our Terraform project uses S3 as the tfstate management provider. Everytime we provision, update and delete resources, Terraform saves the latest infrastructure state into a JSON file, and this file will be stored in S3.

  ```shell
  ❯ aws s3api create-bucket --bucket iac-demo-terraform --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1
  ```

## Getting Started

The project is straightforward, if you are new to terraform and AWS, you should check first how to create an AWS account and create your own AWS access keys.

* [Create and activate an AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
* [AWS account and access keys](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html)

To get your first EC2 up and running, feel free to run the commands, this is assuming that you had finish the installation instructions.

```shell
❯ terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v3.31.0...
- Installed hashicorp/aws v3.31.0 (signed by HashiCorp)

Terraform has been successfully initialized!

...

❯ terraform apply -var-file global.tfvars

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.personal_server will be created
  + resource "aws_instance" "personal_server" {
      + ami                          = "ami-048b4b1ddefe6759f"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "aws-eb-hov"
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "personal-server"
        }
      + tenancy                      = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = true
          + device_name           = "/dev/sda1"
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 20
          + volume_type           = "gp3"
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_security_group.firewall will be created
  + resource "aws_security_group" "firewall" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "ssh traffic"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "web traffic"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "firewall"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
```

Hit `yes` and terraform will create your first EC2 server in AWS.

## CloudFormation Experience

CloudFormation is an AWS in-house tool for creating infrastructure stacks, it occupies the same problem space with Terraform, the difference is it only supports AWS but has the latest features in AWS. This Terraform project will create a CloudFormation stack, you can check the stack details in the CloudFormation console.

```shell
❯ terraform apply -var-file global.tfvars

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_cloudformation_stack.stack will be created
  + resource "aws_cloudformation_stack" "stack" {
      + capabilities  = [
          + "CAPABILITY_IAM",
          + "CAPABILITY_NAMED_IAM",
        ]
      + id            = (known after apply)
      + name          = "PersonalEC2Server"
      + outputs       = (known after apply)
      + parameters    = (known after apply)
      + policy_body   = (known after apply)
      + template_body = <<-EOT
            AWSTemplateFormatVersion : "2010-09-09"
            Description: "Your virtual personal server"

            Resources:
              SecurityGroup:
                Type: "AWS::EC2::SecurityGroup"
                Properties:
                  GroupName: "ec2_firewall"
                  GroupDescription: "your personal server firewall"
                  VpcId: "vpc-c6f987a2"
                  SecurityGroupIngress:
                    - CidrIp: "0.0.0.0/0"
                      FromPort: 22
                      ToPort: 22
                      IpProtocol: "tcp"
                    - CidrIp: "0.0.0.0/0"
                      FromPort: 80
                      ToPort: 80
                      IpProtocol: "tcp"
                    - CidrIp: "0.0.0.0/0"
                      FromPort: 443
                      ToPort: 443
                      IpProtocol: "tcp"
                  SecurityGroupEgress:
                    - CidrIp: "0.0.0.0/0"
                      FromPort: "-1"
                      ToPort: "-1"
                      IpProtocol: "-1"

              EC2:
                Type: "AWS::EC2::Instance"
                Properties:
                  ImageId: "ami-01581ffba3821cdf3"
                  InstanceType: "t3.small" # 2 vCPU, 2GB memory
                  BlockDeviceMappings:
                    - DeviceName: "/dev/sda1"
                      Ebs:
                        DeleteOnTermination: true
                        Encrypted: false
                        Iops: 3000
                        VolumeSize: 50
                        VolumeType: "gp3"
                  SecurityGroupIds:
                    - !Ref SecurityGroup
        EOT
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
```
