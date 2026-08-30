
# Salesforce UI Automation – Copado Robotic Testing (CRT) Framework

This repository contains a UI test automation framework built on **Copado Robotic Testing (CRT)**, targeting a Salesforce application. It follows the **Page Object Model (POM)**, uses **JWT-based authentication to bypass MFA/verification-code** prompts during login, validates business data directly against the Salesforce database using **SOQL**, and supports multi-environment execution through externalized, environment-specific variables.

The framework separates:
  - Test cases
  - Reusable business keywords
  - Page locators
  - Test data
  - Environment configuration
  - Custom Python libraries
  - Salesforce authentication

## About Me

- Hi, my name is Pratik Gupte and I have total 9 years of experience working as a QA Engineer, including 4 years in Salesfore Automation Testing using tools like Selenium Webdriver,RobotFramework, Copado Robotic Testing, API Testing in different Salesforce clouds Sales cloud, Service Cloud and Experience Cloud.
- Currently exploring the Playwright automation using python and AI Testing.
## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/pgupteqa/)

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/pratik-gupte-19145156/)



## Prerequisites

- Copado Robotic Testing account/workspace
- Salesforce Connected App configured for JWT Bearer Flow (with certificate uploaded, pre-authorized, and appropriate OAuth scopes)
- Environment variables configured per org (login URL, client ID, username, certificate reference, etc.)

## Key Highlights

- ✅ Reusable, maintainable POM structure
- ✅ Unattended login bypassing MFA using JWT Bearer Flow
- ✅ Backend data validation (SOQL) in addition to UI assertions — stronger test reliability
- ✅ Multi-environment support via externalized variables
- ✅ Python-based test data management

## Tech Stack

- **Language**: Python, RobotFramework
- **Automation**: RobotFramework Copado Robotic Testing
- **Test Framework**: RobotFramework
- **QForce**: Salesforce-specific keywords(Lightning components, standard SF UI elements, shadow-DOM handling)
- **QWeb**: Core web UI interaction keywords (click, type, verify text, wait strategies)
- **Salesforce**: Application under Test
- **SOQL**: Salesforce Backend data Validation
- **GitHub**: Source Code Management

## Test Data Management

Test data is separated from test implementation using Python-based variable files.
This allows scenarios to retrieve different data sets without hardcoding values directly inside Robot test cases.

Example concept:

Environment
     +
Scenario
     ↓
Test Data Dictionary
     ↓
Robot Framework Variables
     ↓
Reusable Test Keywords

This approach can be extended to support multiple Salesforce environments such as:

- Development
- QA
- UAT
- Staging

**Python Variable file for test data**

```bash
def get_variables(environment, scenario_variable):
 
    data_map ={
        
        "stg_env.create_account":
        {
            "accountname": "TestAccount",
            "Industry": "Banking"
        },

        "prod_env.create_account":
        {
            "accountname": "Prod TestAccount",
            "Industry": "Banking"
        }
    variable_name = f"{environment.lower()}.{scenario_variable}"
    data = data_map.get(variable_name, {})
    
    return data

```

**Running Tests in the CRT**
- Select Target Environment eg: stg_env
- Navigate to the Test Job Configuration
- Add the Execution Variable
- Click on the Run Test Job button
- Select the Run mode and video streaming
- Click on the Run button
- Validate the Results
## Project Files Structure

```bash
Salesforce-UI-Automation-Copado-Robotic-Testing/

│ 
├── data/ 
│   └── sf-server-certificates/ 
│ 
├── libraries/ 
│   └── SalesforceAuthenticationHandlerLib.py 
│ 
├── resources/ 
│   ├── keywords/ 
│   │   ├── auth.resource 
│   │   ├── common.resource 
│   │   ├── Account_Keywords.resource 
│   │   ├── Contact_Keywords.resource 
│   │   └── Case_Keywords.resource 
│   │    
|   ├── page_locators/ 
|   │   ├── AccountPage_locator.resource 
|   │   ├── ContactPage_Locators.resource 
|   │   └── CasePageLocators.resource
|   |
|   └── variables/ 
|   │   ├── env_config.py 
|   |   └── test_data1.py 
|
├── tests/ │ 
|   ├── Regression_suite.robot
|   └── demotest.robot
|
└── README.md

```


## Example Robot TestCase:

```bash

*** Settings ***
Resource                        ../resources/keywords/auth.resource
Resource                        ../resources/keywords/common.resource
Resource                        ../resources/keywords/Account_Keywords.resource
Resource                        ../resources/keywords/Contact_Keywords.resource
Resource                        ../resources/keywords/Case_Keywords.resource

Suite Setup                     Setup Browser
Suite Teardown                  End Suite

*** Test Cases ***
Verify the User Can Create a New Account and Contact Record
    [Documentation]             This keyword is used to Login to the salesforce Via JWT Login
    Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}     create_account
    Login To Salesforce         ${persona_username}
    Create a New Account using API                          ${accountname}              ${Industry}
    Verify Account Record       ${accountname}
    Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}     create_contact
    Create a New Contact Record                             ${lastname}
    Verify Contact Record       ${lastname}


```
## Reports & Logs

- Reports: After execution, a detailed report will be generated inside the CRT.
- The report contains information on test cases executed, passed, failed, and skipped, along with screenshots for failed tests.

https://github.com/pgupteqa/Salesforce-UI-Automation-Copado-Robotic-Testing/blob/master/CRT_Test_result1.png

## Logs:
- Logs are created during the test execution and will be visible under the Test job run report.
## Demo

https://github.com/pgupteqa/Salesforce-UI-Automation-Copado-Robotic-Testing/blob/master/CRT_Automation_Poc_recording.gif

## Project/Test Job Variables

Some External variables are needed to run the test for Salesforce authentication

`browser` : Chrome

`server_key`: generated RSA servery key

`persona_username`: SF username

`crt_environment`: stg_env

`consumer_key`: consumer key for external client app setup for JWT token authentication