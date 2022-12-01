
#CODEBUILD 


resource "aws_iam_role" "codebuild_role" {
  name = "unique"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "codebuild_policy" {
  name = "unique2"
  role = aws_iam_role.codebuild_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
       
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${var.artifacts_bucket_name}/*"
            ],
            "Action": [
                "*"
            ]
        },
        {
          "Effect": "Allow",
          "Resource": [
            "*"
          ],
          "Action": [
            "*"
          ]
        }
    ]
}
EOF
}


#PIPELINE


resource "aws_iam_role" "codepipeline_role" {
  name = "unique3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "unique4"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "*"
      ],
      "Resource": [
        "*" 
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}