# API Contract for User Authentication & Organisation Management
## Table of Contents

1. [Endpoints Overview](#endpoints-overview)
2. [Authentication Endpoints](#authentication-endpoints)
3. [User Registration](#user-registration)
4. [User Login](#user-login)
5. [User Endpoints](#user-endpoints)
6. [Get User Information](#get-user-information)
7. [Organisation Endpoints](#organisation-endpoints)
8. [Get User Organisations](#get-user-organisations)
9. [Get Organisation by ID](#get-organisation-by-id)
10. [Create Organisation](#create-organisation)
11. [Add User to Organisation](#add-user-to-organisation)
12. [Response Structure](#response-structure)

## Endpoints Overview
| Endpoint	                         | Method	           | Description                                      |
|-----------------------------------|-------------------|--------------------------------------------------|
| `/auth/register`                  | 	POST             | Register a new user and create an organisation   |
| `/auth/login`                     | 	POST             | Log in a user and generate JWT token             |
| `/api/users/:id`                  | 	GET	             | Get user information by ID                       |
| `/api/organisations`              | 	GET	             | Get all organisations the user belongs to        |
| `/api/organisations/:orgId`       | 	GET	             | Get organisation details by ID                   |
| `/api/organisations`	             | POST              | 	Create     a new organisation                   |
| `/api/organisations/:orgId/users` | 	POST             | Add a user to an organisation                    |

## Authentication Endpoints
### User Registration

- Endpoint: /auth/register
- Method: POST
- Description: Register a new user and create a default organisation.

#### Request Body:
```json
{
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "password": "string",
  "phone": "string"
}

```
#### Successful Response:

```json
{
  "status": "success",
  "message": "Registration successful",
  "data": {
    "accessToken": "eyJh...",
    "user": {
      "userId": "string",
      "firstName": "string",
      "lastName": "string",
      "email": "string",
      "phone": "string"
    }
  }
}

```

#### Unsuccessful Response:
```json
{
  "status": "Bad request",
  "message": "Registration unsuccessful",
  "statusCode": 400
}
```

### User Login

- Endpoint: /auth/login
- Method: POST
- Description: Log in a user and generate JWT token.

#### Request Body:
```json
{
  "email": "string",
  "password": "string"
}
```
#### Successful Response:
```json
{
  "status": "success",
  "message": "Login successful",
  "data": {
    "accessToken": "eyJh...",
    "user": {
      "userId": "string",
      "firstName": "string",
      "lastName": "string",
      "email": "string",
      "phone": "string"
    }
  }
}
```
#### Unsuccessful Response:
```json

{
  "status": "Bad request",
  "message": "Authentication failed",
  "statusCode": 401
}
```

## User Endpoints
### Get User Information

- Endpoint: /api/users/:id
- Method: GET
- Description: Get user information by ID.

#### Request Headers:

```http
Authorization: Bearer <JWT_TOKEN>
```

#### Successful Response:

```json
{
  "status": "success",
  "message": "<message>",
  "data": {
    "userId": "string",
    "firstName": "string",
    "lastName": "string",
    "email": "string",
    "phone": "string"
  }
}
```
## Organisation Endpoints
### Get User Organisations

- Endpoint: /api/organisations
- Method: GET
- Description: Get all organisations the user belongs to.

#### Request Headers:

```http
Authorization: Bearer <JWT_TOKEN>
```

#### Successful Response:

```json
{
  "status": "success",
  "message": "<message>",
  "data": {
    "organisations": [
      {
        "orgId": "string",
        "name": "string",
        "description": "string"
      }
    ]
  }
}
```

### Get Organisation by ID

- Endpoint: /api/organisations/:orgId
- Method: GET
- Description: Get organisation details by ID.

#### Request Headers:
```http
Authorization: Bearer <JWT_TOKEN>
```
#### Successful Response:
```json
{
    "status": "success",
    "message": "<message>",
    "data": {
        "orgId": "string",
        "name": "string",
        "description": "string"
    }
}
```

### Create Organisation
- Endpoint: /api/organisations
- Method: POST
- Description: Create a new organisation.

#### Request Headers:
```http
Authorization: Bearer <JWT_TOKEN>
```
#### Request Body:

```json

{
    "name": "string",
    "description": "string"
}
```

#### Successful Response:

```json
{
    "status": "success",
    "message": "Organisation created successfully",
        "data": {
        "orgId": "string",
        "name": "string",
        "description": "string"
    }
}
```

#### Unsuccessful Response:

```json
{
    "status": "Bad Request",
    "message": "Client error",
    "statusCode": 400
}
```

### Add User to Organisation

- Endpoint: /api/organisations/:orgId/users
- Method: POST
- Description: Add a user to an organisation.

#### Request Headers:

```http
Authorization: Bearer <JWT_TOKEN>
```

#### Request Body:
```json
{
    "userId": "string"
}
```

#### Successful Response:

```json
{
    "status": "success",
    "message": "User added to organisation successfully"
}
```

## Response Structure
### Common Fields
    status: Indicates the status of the response (success, Bad request, etc.).
    message: A message providing additional details about the response.

### Error Response

    statusCode: HTTP status code indicating the type of error.

#### Example Error Response

```json
{
    "status": "Unprocessable Entity",
    "message": "Validation errors",
    "statusCode": 422,
    "errors": [
        {
            "field": "firstName",
            "message": "First name is required"
        }, {
             "field": "email",
            "message": "Email is invalid"
        }
    ]
}
```
