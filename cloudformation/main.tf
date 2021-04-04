resource "aws_cloudformation_stack" "stack" {
  name          = "PersonalEC2Server"
  capabilities  = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  template_body = file("stack/personal-ec2.yaml")
}
