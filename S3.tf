resource "aws_s3_bucket" "artifacts_bucket_name" {
  bucket = "bucket233"  
  acl    = "private"

  tags = {
    Name        ="bucket"
  }  
}
 
