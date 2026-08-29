*** Settings ***
Library                         ../resources/variables/test_data.py
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