# User Authentication & Organisation Management System

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
5. [Configuration](#configuration)
6. [Running the Application](#running-the-application)
7. [API Endpoints](#api-endpoints)
8. [Error Handling](#error-handling)
9. [Testing](#testing)
10. [Contact](#contact)

## Introduction
This is a Spring Boot application for managing user authentication and organisation relationships. It allows users to register, log in, and manage organisations they belong to or create. The application connects to a PostgreSQL database for data persistence.

## Features
- User registration with password hashing
- User login with JWT token generation
- Organisation creation and management
- Users can belong to multiple organisations
- Organisation can have multiple users
- Secure endpoints with JWT authentication

## Technologies Used
- Spring Boot
- Spring Security
- Spring Data JPA
- PostgreSQL
- JWT (JSON Web Tokens)
- Maven
- Lombok

## Getting Started

### Prerequisites
- Java Development Kit (JDK) 11 or higher
- Maven
- PostgreSQL database

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Configure the PostgreSQL database:**
    - Create a PostgreSQL database and note down the database URL, username, and password.

3. **Configure the application:**
    - Update the `src/main/resources/application.properties` file with your PostgreSQL database credentials.

4. **Build the application:**
   ```bash
   mvn clean install
   ```

## Configuration
Update the `src/main/resources/application.properties` file with your database configurations:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/your_database
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
```

## Running the Application
Run the Spring Boot application using Maven:
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`.

## API Endpoints

### Authentication Endpoints

#### Register a new user
**Endpoint:** `/auth/register`  
**Method:** POST  
**Request Body:**
```json
{
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "password": "string",
  "phone": "string"
}
```
**Response:**
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

#### Log in a user
**Endpoint:** `/auth/login`  
**Method:** POST  
**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```
**Response:**
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

### User Endpoints

#### Get user information by ID
**Endpoint:** `/api/users/:id`  
**Method:** GET  
**Headers:**
```http
Authorization: Bearer <JWT_TOKEN>
```
**Response:**
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

### Organisation Endpoints

#### Get all organisations the user belongs to
**Endpoint:** `/api/organisations`  
**Method:** GET  
**Headers:**
```http
Authorization: Bearer <JWT_TOKEN>
```
**Response:**
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

#### Get organisation details by ID
**Endpoint:** `/api/organisations/:orgId`  
**Method:** GET  
**Headers:**
```http
Authorization: Bearer <JWT_TOKEN>
```
**Response:**
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

#### Create a new organisation
**Endpoint:** `/api/organisations`  
**Method:** POST  
**Headers:**
```http
Authorization: Bearer <JWT_TOKEN>
```
**Request Body:**
```json
{
  "name": "string",
  "description": "string"
}
```
**Response:**
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

#### Add a user to an organisation
**Endpoint:** `/api/organisations/:orgId/users`  
**Method:** POST  
**Headers:**
```http
Authorization: Bearer <JWT_TOKEN>
```
**Request Body:**
```json
{
  "userId": "string"
}
```
**Response:**
```json
{
  "status": "success",
  "message": "User added to organisation successfully"
}
```

## Error Handling
### Validation Errors
**Response:**
```json
{
  "status": "Unprocessable Entity",
  "message": "Validation errors",
  "statusCode": 422,
  "errors": [
    {
      "field": "firstName",
      "message": "First name is required"
    },
    {
      "field": "email",
      "message": "Email is invalid"
    }
  ]
}
```

### Authentication Errors
**Response:**
```json
{
  "status": "Bad request",
  "message": "Authentication failed",
  "statusCode": 401
}
```

## Testing
Run tests using Maven:
```bash
mvn test
```


## Contact
For questions or suggestions, please contact [gbodisegun@gmail.com](mailto:gbodisegun@gmail.com).

---
