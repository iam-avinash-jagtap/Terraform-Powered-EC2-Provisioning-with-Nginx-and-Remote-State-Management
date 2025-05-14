resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Terra-Remote-DB-table--004"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terra-Remote-DB-table--004"

  }
}