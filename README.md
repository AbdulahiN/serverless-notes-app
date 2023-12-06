# Serverless Notes Management Application
![image](https://github.com/AbdulahiN/serverless-notes-app-lambda-dynamodb/blob/main/diagrams/diagram.png) 

# Introduction
This document outlines the development and deployment of my Serverless Notes Management Application. It's a clear indicator of my journey and expertise in cloud-native technologies. Built within the AWS ecosystem, the application uses Lambda functions, API Gateway, and DynamoDB to create a resilient and scalable note-taking platform. This project not only demonstrates my abilities with AWS services but also highlights my skills in employing Terraform for infrastructure as code (IaC), showcasing my understanding of serverless architecture principles.

## Application Architecture

### Crafting the Serverless Solution
I designed a solution for managing notes that involved AWS Lambda for business logic execution, API Gateway for RESTful API exposure, and DynamoDB for persistently storing notes. This combination ensured a fast, scalable, and efficient system.

### Terraform and IaC
I used Terraform for declarative infrastructure management. This streamlined the setup and allowed me to version control my infrastructure, making it easy to replicate or modify.

## Application Workflow

### API Gateway and Lambda Functions
The API Gateway in my setup acts as the front door, routing client requests to the appropriate Lambda function based on the HTTP method. `PUT` requests trigger Lambda functions to store new notes in DynamoDB, while `GET` requests are used to retrieve notes.

### Continuous Integration/Deployment
I integrated GitHub Actions for CI/CD, ensuring any commits to the repository automatically triggered building and deployment processes. This setup kept the application updated and reduced the need for manual deployment.

## Testing the Application

After deploying the application, I conducted tests to ensure functionality:

### Testing PUT Requests
To create a new note, I used Postman:

- Set the request to `PUT`.
- Entered the API Gateway endpoint URL.
- In the body, included a JSON object: `{"content": "This is a test note", "noteId": "1"}`.
- Sent the request and received a confirmation of note creation.

![image](https://github.com/AbdulahiN/serverless-notes-app-lambda-dynamodb/blob/main/diagrams/postman1.png)
### Testing GET Requests
For retrieving a note:

- Set the request to `GET`.
- Used the same endpoint URL with `/1` to retrieve the note with `noteId` "1".
- Sent the request and received the content of the note as a response.
  
![image](https://github.com/AbdulahiN/serverless-notes-app-lambda-dynamodb/blob/main/diagrams/postman2.png)

These tests confirmed that my Lambda functions were processing requests correctly and interacting seamlessly with DynamoDB.

## Reflection and Conclusion
This Serverless Notes Management Application is not just a showcase of technical skills; it's a reflection of my strategic approach to problem-solving using serverless paradigms. It highlights my dedication to modern cloud practices and sets the stage for more complex cloud-based projects in the future.
