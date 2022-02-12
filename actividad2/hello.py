def greetings(event, context):
    hello = "Hello world!. This is a Lambda function."
    print(hello)
    return {
        'statusCode' : 200,
        'body': hello
    }