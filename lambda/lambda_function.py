import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('serverless-portfolio-counter')

def lambda_handler(event, context):
    try:
        # Ask DynamoDB to add 1 to the 'count' attribute where id = 'visitors'
        response = table.update_item(
            Key={
                'id': 'visitors'
            },
            UpdateExpression='SET #c = #c + :val',
            ExpressionAttributeNames={
                '#c': 'count'
            },
            ExpressionAttributeValues={
                ':val': 1
            },
            ReturnValues="UPDATED_NEW"
        )
        
        # Get the new number from the response
        new_count = response['Attributes']['count']
        
        # Return the number to the website with permission headers
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps({'count': int(new_count)})
        }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
