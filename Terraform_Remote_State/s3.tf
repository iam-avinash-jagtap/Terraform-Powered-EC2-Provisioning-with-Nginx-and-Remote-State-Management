resource "aws_s3_bucket" "My-Bucket" {
  bucket = "terra-remote-bucket--004"
  tags = {
   Name = "terraform_remote_state_bucket_004" 
  }
}