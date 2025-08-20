# MySMS Messenger API

This is the API for MySMS Messenger, a web application that allows users to send SMS messages through Twilio integration.

## Features

- User authentication using Devise and JWT
- SMS sending capabilities via Twilio
- Message storage and retrieval
- Message status tracking via webhooks
- MongoDB database integration
- RESTful API endpoints for message management

## Prerequisites

- Ruby 3.x
- MongoDB
- Twilio account with:
  - Account SID
  - Auth Token
  - Phone number

## System Dependencies

The application uses the following main dependencies:

- Rails 8.0.2
- MongoDB (via Mongoid)
- Devise & Devise-JWT for authentication
- Twilio Ruby SDK
- Solid Queue for background job processing
- Kamal for deployment

## Setup and Configuration

1. Clone the repository:

   ```bash
   git clone [repository-url]
   cd sms-api
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Configure environment variables:
   Create a `.env` file in the root directory with:

   ```
   MONGODB_URI=your_mongodb_uri
   ```

4. Configure Twilio credentials:

   ```bash
   EDITOR="code --wait" bin/rails credentials:edit
   ```

   Add your Twilio credentials (you can find these in your Twilio Console):

   ```yaml
   twilio:
     account_sid: "your_twilio_account_sid"
     auth_token: "your_twilio_auth_token"
     phone_number: "+your_twilio_number"
   ```

5. Setup MongoDB:
   The application will automatically connect to MongoDB using the URI provided in your `.env` file.

   To create indexes and set up initial collections, run:

   ```bash
   rails console
   >> Mongoid::Tasks::Database.create_indexes
   ```

## Running the Application

1. Start the Rails server:

   ```bash
   rails server
   ```

2. For development with Twilio webhooks, use ngrok:
   ```bash
   ngrok http 3000
   ```
   Add the following to .env:
   ````APP_HOST=your_ngrok_forwarding_address
       PROTOCOL=https```
   ````

## Testing

Run the test suite with:

```bash
rails test
```

## API Endpoints

- POST `/users/sign_up` - User registration
- POST `/users/sign_in` - User login
- DELETE `/users/sign_out` - User logout
- POST `/messages` - Send a new SMS
- GET `/messages` - List user's messages
- GET `/messages/:id` - Get specific message details

## Services

The application uses several key services:

- MongoDB for data storage
- Solid Queue for background job processing
- Twilio for SMS delivery
- JWT for stateless authentication

## Deployment

This application can be deployed using Kamal, which packages the application as a Docker container:

```bash
bin/kamal deploy
```
