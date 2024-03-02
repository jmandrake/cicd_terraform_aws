import json
import os
import fxAddressCheck as fx


os.environ['AWS_PROFILE'] = "default"
os.environ['AWS_DEFAULT_REGION'] = "us-east-1"

os.environ['apiKey'] = "xxxxxxxxxxxxx"
os.environ['apiUrl'] = "https://api.addressy.com/Capture/Interactive/Retrieve/v1.00/json3.ws"
os.environ['userId'] = "jmandrake"


def main():
    context = None

    message = {
        "orderId": "F7E456541",
        "requestType": "Address",
        "requestId": {
                        "partition": "id-AddressCheck-001",
                        "sort_key": "psk-Address-aaa-bbb-ccc-1"
                        }
    }

    body = json.dumps(message)

    event = {
        "Records": [
            {
                "body": json.dumps(body)
            }
        ]
    }

    print("event: ", event)

    fx.lambda_handler(event, context)



if __name__ == "__main__":
    main()
    print("done")

