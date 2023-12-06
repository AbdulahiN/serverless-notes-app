import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    table = dynamodb.Table('NotesTable')

    try:
        # Check if 'httpMethod' exists in the event
        http_method = event.get('httpMethod')

        if http_method == 'PUT':
            # Load and validate the body content
            body = json.loads(event.get('body', '{}'))
            note_id = body.get('noteId')
            content = body.get('content')

            if not note_id or not content:
                return {
                    'statusCode': 400,
                    'body': json.dumps('Missing noteId or content')
                }

            table.put_item(
                Item={
                    'noteId': note_id,
                    'content': content
                }
            )

            response = {
                'statusCode': 200,
                'body': json.dumps(f'Note {note_id} created successfully.')
            }

        elif http_method == 'GET':
            # Extract and validate the noteId from pathParameters
            note_id = event.get('pathParameters', {}).get('noteId')  # Corrected to 'noteId'
            if not note_id:
                return {
                    'statusCode': 400,
                    'body': json.dumps('Note ID not provided')
                }

            result = table.get_item(
                Key={
                    'noteId': note_id
                }
            )
            item = result.get('Item', {})

            response = {
                'statusCode': 200,
                'body': json.dumps(item)
            }

        else:
            response = {
                'statusCode': 400,
                'body': json.dumps('Unsupported HTTP method')
            }

    except ClientError as e:
        response = {
            'statusCode': 500,
            'body': json.dumps('Internal Server Error')
        }

    return response
