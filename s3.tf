resource "aws_s3_bucket" "artifactory" {
bucket = "artifactory-cicd-labs-demo1"
tags = {
    Name = "artifactory-cicd-labs-demo1"
  }
}
