terraform {
  backend "s3" {
    bucket = "sctp-ce2-tfstate-bkt"   # hold terraform state file in S3 bucketß
    key    = "serverless-app-assignment-SimonOng.tfstate"   #Change the value  of this to yourname-ecs-1.tfstate for  example
    region = "ap-southeast-1"         # Region - Singapore
  }
}
