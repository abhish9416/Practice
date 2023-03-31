variable "provider_region" {
  type        = string
  default     = "us-west-2"
  description = "Region to operate terraform"
}
variable "ec2_details" {
  type = object({
    ami_id        = string
    instance_type = string
  })
  default = {
    ami_id        = "ami-0fcf52bcf5db7b003"
    instance_type = "t2.micro"
  }

}