import json

def lambda_handler(event, context):
    # TODO implement
    print("event: ", event)
    print("context: ", context)
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda --> questions_lambda 888')
    }