#import "@preview/rubber-article:0.3.2": *

#show: article.with(
  show-header: true,
  header-title: "Homework #7",
  eq-numbering: "(1.1)",
  eq-chapterwise: true,
)

#maketitle(
  title: "API Testing",
  authors: ("Individual Report - 22127201",),
  date: datetime.today().display("[day]. [month repr:long] [year]"),
)

= Tasks Allocation

#v(1.5em)

#figure(
  table(
    columns: 3,
    align: (center, left, left),
    stroke: 0.5pt + black, // Adds 1pt black grid lines
    [*Student ID*], [*Name*], [*Scenario*],
    [22127201], [Võ Hoàng Anh Khoa], [1. Change Password
  2. Edit User
3. Edit Product],
    [22127216], [Nguyễn Đình Kiên], [1. Payment
  2. Send New Contact Message
3. Send Reply Contact Message],
  [22127268], [Nguyễn Hữu Minh], [1. Sign In
2. Sign Up
3. Add Product (Admin)],
[22127487], [Phạm Trịnh Bảo Tín], [1. Search/Filter
2. Add to Favorites
3. Add Invoices]
  ),
)

// Some example content has been added for you to see how the template looks like.
= Set Up and Deployment

== Repository Cloning:

The original GitHub repository
#link("https://github.com/testsmith-io/practice-software-testing")[
  #text("practice-software-testing", fill: rgb("#3366CC"))
] was cloned to my personal repository at #link("https://github.com/vhakHCMUS/testingHW")[
  #text("testingHW", fill: rgb("#3366CC"))
]

== Local Deployment

The corresponding source code was downloaded and
deployed on a local machine, as instructed for the assignment.

= API Testing Details

== Change Password API
- API Name: Change Password
- URL: http://localhost:8091/users/change-password
- HTTP Method: *POST*
- Prerequisite: User is authenticated
- Example Body:
  ```json
  {
    "current_password": "welcome01",
    "new_password": "NewPassword456@",
    "new_password_confirmation": "NewPassword456@"
  }
  ```
- Screenshots:
#image("CHANGE_PASSWORD.png")
- Observed Response:
  - Status Code: #text("200 OK", fill: green) for valid password changes
  - Validates password complexity requirements: minimum 8 characters, uppercase, lowercase, numbers, and symbols
  - Returns #text("422 Unprocessable Entity", fill: red) for validation errors
  - Returns #text("400 Bad Request", fill: red) for wrong current password or same password attempts
  - Returns #text("401 Unauthorized", fill: red) when unauthenticated
- Total Test Cases Executed: 39
- Test Case Summary:
  - Valid password changes with various character sets (unicode, special characters)
  - Password validation rules (length, complexity requirements)
  - Authentication and authorization checks
  - Edge cases: duplicate passwords, malformed JSON, empty fields
  - Security tests: XSS attempts, SQL injection attempts
- Test Cases Failed: #text("3", fill: red)
- Failed Test Cases Details:
  - [TC018] Weak password (common): Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC029] Common/weak password: Expected #text("422", fill: red) Got #text("200", fill: green)  
  - [TC037] Rate limiting test: Expected #text("429", fill: red) Got #text("200", fill: green)
- Example of Passed Test Cases:
  - [TC001] Valid password change: #text("200 OK", fill: green)
  - [TC007] Wrong current password: #text("400 Bad Request", fill: red)
  - [TC010] New password too short: #text("422 Unprocessable Entity", fill: red)
  - [TC034] No authentication token: #text("401 Unauthorized", fill: red)

== Edit User API
- API Name: Edit User
- URL: http://localhost:8091/users/{{user_id}}
- HTTP Method: *PUT*
- Prerequisite: User is authenticated
- Example Body:
  ```json
  {
    "first_name": "John",
    "last_name": "Doe", 
    "email": "john.doe@example.com",
    "phone": "+84901234567",
    "dob": "1985-06-15",
    "address": {
      "street": "123 Main St",
      "city": "Ho Chi Minh City",
      "state": "HCMC",
      "country": "Vietnam",
      "postal_code": "70000"
    }
  }
  ```
- Screenshots:
#image("USER_UPDATE.png")
- Observed Response:
  - Accepts complete user profile updates with personal and address information
  - Validates field length constraints and required fields
  - Handles Vietnamese unicode characters properly
  - Enforces business rules: minimum age 18, valid email formats
  - Returns appropriate error codes for validation failures
- Total Test Cases Executed: 49
- Test Case Summary:
  - Complete profile updates with all fields
  - Single field updates (first_name, email, address, phone)
  - Field validation: length limits, required fields, format validation
  - Age validation: minimum 18 years old, future dates rejected
  - Security tests: XSS prevention, SQL injection attempts
  - Authentication and authorization scenarios
- Test Cases Failed: #text("5", fill: red)
- Failed Test Cases Details:
  - [TC033] Invalid phone format - letters: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC037] Invalid postal code format: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC043] Update another user's profile: Expected #text("403", fill: red) Got #text("200", fill: green)
  - [TC046] Non-existent user ID: Expected #text("404", fill: red) Got #text("200", fill: green)
  - [TC047] Invalid user ID format: Expected #text("400", fill: red) Got #text("200", fill: green)
- Example of Passed Test Cases:
  - [TC001] Complete user profile update: #text("200 OK", fill: green)
  - [TC009] Empty first_name: #text("422 Unprocessable Entity", fill: red)
  - [TC022] User under 18 years old: #text("422 Unprocessable Entity", fill: red)
  - [TC040] No authentication token: #text("401 Unauthorized", fill: red)

== Edit Product API
- API Name: Edit Product  
- URL: http://localhost:8091/products/{{productId}}
- HTTP Method: *PUT*
- Prerequisite: Admin authentication required
- Example Body:
  ```json
  {
    "name": "Updated Product Name",
    "description": "Updated product description",
    "price": 19.99,
    "category_id": "1", 
    "brand_id": "1",
    "product_image_id": "1",
    "is_location_offer": 0,
    "is_rental": 0
  }
  ```
- Screenshots:
#image("PRODUCT_UPDATE.png")
- Observed Response:
  - Successfully updates product information with #text("200 OK", fill: green)
  - Dynamic ID system automatically fetches valid product, category, and brand IDs from database
  - Validates required fields and data types
  - Handles various product configurations (location offers, rental options)
  - Returns validation errors for invalid data
- Total Test Cases Executed: 50
- Test Case Summary:
  - Complete product updates with all fields
  - Single field updates (name, description, category, brand, pricing)
  - Dynamic ID replacement system for database-independent testing
  - Validation tests: field lengths, required fields, data types
  - Special product features: location offers, rental options
  - Authentication and authorization checks
  - Error scenarios: non-existent IDs, invalid formats
- Test Cases Failed: #text("12", fill: red)
- Failed Test Cases Details:
  - [TC013] Empty product name: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC014] Empty description: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC015] Invalid category_id: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC016] Invalid brand_id: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC017] Invalid supplier_id: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC018] Name too long: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC019] Description too long: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC034] String values for numeric fields: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC035] Float values for boolean fields: Expected #text("422", fill: red) Got #text("200", fill: green)
  - [TC042] Non-existent product ID: Expected #text("404", fill: red) Got #text("200", fill: green)
  - [TC043] Invalid product ID format: Expected #text("400", fill: red) Got #text("200", fill: green)
  - [TC039] Update another user's product: Expected #text("403", fill: red) Got #text("200", fill: green)
- Example of Passed Test Cases:
  - [TC001] Complete product update: #text("200 OK", fill: green)
  - [TC009] Enable location offer: #text("200 OK", fill: green)
  - [TC011] Enable both location offer and rental: #text("200 OK", fill: green)
  - [TC036] No authentication token: #text("401 Unauthorized", fill: red)

= Integration into CI Workflow

- CI Workflow Demo: #link("")[
  #text("API Testing", fill: rgb("#3366CC"))
]
- Workflow File:
  ```
    .github/
    └── workflows/
      └── api-testing.yml
  ```
- API Test Collection:
  - `HW07_local_postman_collection.json`
  - `password_change.csv`
  - `users_update.csv` 
  - `product_update.csv`
- Automated Execution:
  ```yml
  ...
  - name: Run HW07 Local Test Collection
        run: |
          newman run "HW07_local_postman_collection.json" \
            --iteration-data password_change.csv \
            --reporters cli,json,html \
            --reporter-json-export newman/password-change-report.json \
            --reporter-html-export newman/password-change-report.html
        continue-on-error: true
  ...
  ```

= Use of AI/LLM Tools: 

- Tools: GitHub Copilot
- Prompts:
  - For generating test cases:
    - *Change Password API*: Generate comprehensive test cases for password change API in CSV format covering validation rules, security requirements, edge cases, and authentication scenarios. Include cases for password complexity requirements, current password verification, and confirmation matching.
    - *Edit User API*: Generate test cases for user profile update API with personal information and address validation. Cover field length limits, required field validation, age restrictions, email format validation, and unicode character support.
    - *Edit Product API*: Generate test cases for product update API with dynamic ID fetching system. Include validation for product fields, category/brand relationships, pricing, and special product features like location offers and rentals.
  - For writing dynamic ID system: Implement pre-request script that fetches valid product, category, and brand IDs from database APIs and replaces DYNAMIC placeholders in CSV data to ensure tests work regardless of database seeding.
  - For authentication handling: Create auth mode system that handles various authentication scenarios including valid tokens, invalid tokens, expired tokens, and missing authentication headers.
- Validation:
  - All requests tested using Postman collection runner with CSV data iteration
  - Dynamic ID system tested and confirmed to fetch real database IDs
  - Authentication pre-scripts validated for token management
  - Test script assertions include:
    - Status code validation (200, 400, 401, 403, 404, 422)
    - Response message validation for error cases
    - JSON structure validation for success responses
  - Collection runner confirms:
    - 138+ tests executed across all three APIs
    - Login success with token persistence
    - Pass/fail statistics tracked per test case
    - Failed cases documented with expected vs actual results

= Self-Assessment

#table(
  columns: 4,
  align: (left, left, center, center),
  stroke: 0.5pt + black,
  inset: 6pt,

  [*Criteria*], [*Outcomes (Brief description about what you get/trouble from each requirement)*], [*Percent*], [*Self-Assessed Grade*],

  [*1*], [*Change Password*], [30%], [*27%*],
  [], [1.1 Report], [15], [15],
  [], [1.2 Test Cases (39)], [5], [5],
  [], [1.3 Screenshots on Testing Tools], [5], [5],
  [], [1.4 Bugs], [5], [2],

  [*2*], [*Edit User*], [30%], [*27%*],
  [], [2.1 Report], [15], [15],
  [], [2.2 Test Cases (49)], [5], [5],
  [], [2.3 Screenshots on Testing Tools], [5], [5],
  [], [2.4 Bugs], [5], [2],

  [*3*], [*Edit Product*], [30%], [*24%*],
  [], [3.1 Report], [15], [15],
  [], [3.2 Test Cases (50)], [5], [5],
  [], [3.3 Screenshots on Testing Tools], [5], [5],
  [], [3.4 Bugs], [5], [-1],

  [*4*], [*Well formatted*], [10%], [*10%*],

  [], [*Total*], [*100%*], [*88%*],
)
