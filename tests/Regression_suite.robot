*** Settings ***
Library                         ../resources/variables/test_data.py
Resource                        ../resources/keywords/common.resource
Resource                        ../resources/keywords/Account_Keywords.resource
Resource                        ../resources/keywords/Contact_Keywords.resource
Resource                        ../resources/keywords/Case_Keywords.resource

Suite Setup                     Run Keywords                Setup Browser               Login to Salesforce Org as AdminUser
Test Setup                      Get Test Data
Suite Teardown                  End Suite


*** Test Cases ***
Verify the User Can Create a New Account and Contact Record
    [Documentation]             This keyword is used to Login to the salesforce Via JWT Login
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke
    #Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_account
    Create a New Account using API                          ${accountname}              ${Industry}
    Verify Account Record       ${accountname}
    #Get testdata for create a new contact record
    #Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_contact
    Create a New Contact Record                             ${lastname}
    Verify Contact Record       ${lastname}

Verify a New Case Creation on a Contact
    [Documentation]             Agent user can create a new case with required Fields
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke    ${crt_environment}_case_regression
    #Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}          create_case
    #Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_case
    Create a New Case Record    ${subject}                  ${description}              ${account}                  ${contact}    ${priority}              ${caseorigin}
    Validate the Case using the generated CaseNumber        ${sfbaseurl}                ${newcasenumber}
    Validate a Case Record Using SOQL Query                 ${newcasenumber}            description                 priority

Verify a New Case Creation on a Contact using Data Tables
    [Documentation]             Agent user can create a new case with required Fields
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke    ${crt_environment}_case_regression_datatable
    #Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_case
    Create a New Case Record    ${CaseTable.Subject}        ${CaseTable.Description}    ${account}                  ${contact}    ${CaseTable.Priority}    ${CaseTable.CaseOrigin}
    Validate the Case using the generated CaseNumber        ${sfbaseurl}                ${newcasenumber}

*** Keywords ***
Get Test Data
    [Documentation]             Add all test data file path into this variable
    Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_account
    Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_contact
    Import Variables            ../data/testdata/stgenv_testdata.py                     ${crt_environment}          create_case           