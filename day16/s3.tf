resource "aws_s3_bucket" "seit-s3-1" {
  bucket = "siet-s3-bucket-001"
  tags = {
    Name        = "siet-sample-bucket-001"
    team        = var.tag_team
    config_platform = var.tag_platform
  }
}