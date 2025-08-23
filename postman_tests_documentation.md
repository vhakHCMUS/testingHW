# API Test Cases Documentation - Postman Collection

This repository contains a Postman collection and CSV files for testing the Update User API and Change Password API. The test cases are designed to validate various scenarios including valid inputs, invalid inputs, authentication issues, and edge cases.

## Collection Structure

The Postman collection (`HW07_postman_collection.json`) contains two main folders:

1. **Update-User**: Contains test cases for updating user profile information
2. **Change-Password**: Contains test cases for changing user passwords

## Test Data

Test data is provided in CSV format:

1. **users_update.csv**: Contains test data for the Update User API tests
2. **password_change.csv**: Contains test data for the Change Password API tests

## How to Use the Collection

### Prerequisites

1. Postman installed on your computer
2. A running instance of the API

### Setup Steps

1. Import the Postman collection (`HW07_postman_collection.json`)
2. Create an environment in Postman with the following variables:
   - `BASE_API_URL`: The base URL of your API (e.g., `http://localhost:8000/api`)
   - `TOKEN`: A valid JWT token for authentication
   - `user_id`: The ID of the user being tested

### Running Tests

1. **Update User Tests**:
   - Select the "Update User" request in the "Update-User" folder
   - Click on the "Runner" button in Postman
   - Select the collection and the "Update User" request
   - Choose the `users_update.csv` file as the data source
   - Configure iterations and run the tests

2. **Change Password Tests**:
   - Select the "Change Password" request in the "Change-Password" folder
   - Click on the "Runner" button in Postman
   - Select the collection and the "Change Password" request
   - Choose the `password_change.csv` file as the data source
   - Configure iterations and run the tests

## Test Cases Summary

### Update User API Test Cases (30 Test Cases)

#### Valid Data Test Cases (8 cases)
- TC001: Complete user profile update
- TC002: Minimum valid data update
- TC003: Update with Vietnamese characters
- TC004: Update single field (first_name only)
- TC005: Update single field (email only)
- TC006: Update address only
- TC007: Update phone number only
- TC008: Maximum field lengths (boundary test)

#### Invalid Data Test Cases (12 cases)
- TC009: Empty first_name
- TC010: Empty last_name
- TC011: Invalid email format - missing @
- TC012: Invalid email format - missing domain
- TC013: Invalid phone format - letters
- TC014: Phone too short
- TC015: Phone too long
- TC016: Exceeding field length - first_name
- TC017: Exceeding field length - email
- TC018: Invalid postal code format
- TC019: SQL injection attempt in first_name
- TC020: XSS attempt in last_name

#### Authentication & Authorization Test Cases (6 cases)
- TC021: No authentication token
- TC022: Invalid authentication token
- TC023: Expired authentication token
- TC024: Update another user's profile
- TC025: Malformed Bearer token
- TC026: Missing Authorization header

#### Edge Cases & Error Handling (4 cases)
- TC027: Non-existent user ID
- TC028: Invalid user ID format
- TC029: Empty request body
- TC030: Malformed JSON

### Change Password API Test Cases (25 Test Cases)

#### Valid Password Change Test Cases (6 cases)
- TC001: Valid password change
- TC002: Minimum password requirements
- TC003: Maximum password length
- TC004: Password with Vietnamese characters
- TC005: Special characters in password
- TC006: Numeric password meeting criteria

#### Invalid Current Password Test Cases (4 cases)
- TC007: Wrong current password
- TC008: Empty current password
- TC009: Current password too long
- TC010: Special characters in current password verification

#### New Password Validation Test Cases (8 cases)
- TC011: New password too short
- TC012: New password without uppercase
- TC013: New password without lowercase
- TC014: New password without numbers
- TC015: New password without special characters
- TC016: Common/weak password
- TC017: Password same as current
- TC018: Empty new password

#### Password Confirmation Test Cases (3 cases)
- TC019: Password confirmation mismatch
- TC020: Empty password confirmation
- TC021: Case sensitive confirmation check

#### Authentication & Security Test Cases (4 cases)
- TC022: No authentication token
- TC023: Invalid authentication token
- TC024: Expired authentication token
- TC025: Rate limiting test
