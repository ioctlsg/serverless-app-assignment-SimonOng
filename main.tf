data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service" 
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:simonongsqs"] # change to the sqs name u want
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.bucket.arn]
    }
  }
}

resource "aws_sqs_queue" "queue" {
  name   = "simonongsqs" #create the sqs
  policy = data.aws_iam_policy_document.queue.json
}

resource "aws_s3_bucket" "bucket" {
  bucket = "simonongbucket"#create the S3 bucket
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*","s3:ObjectRemoved:*"] #this is an array use so ["string A","String B"]
  }
}