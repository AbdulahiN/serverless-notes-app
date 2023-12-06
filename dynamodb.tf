resource "aws_dynamodb_table" "notes_table" {
  name           = "NotesTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "noteId"

  attribute {
    name = "noteId"
    type = "S"
  }
}
