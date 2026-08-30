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
    [Tags]                      regression    smoke        
    Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}     create_account
    Login To Salesforce         ${persona_username}
    Create a New Account using API                          ${accountname}              ${Industry}
    Verify Account Record       ${accountname}
    Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}     create_contact
    Create a New Contact Record                             ${lastname}
    Verify Contact Record       ${lastname}

Verify a New Case Creation on a Contact
    [Documentation]             Agent user can create a new case with required Fields
    [Tags]                      regression    smoke    ${crt_environment}_case_regression
    Import Variables            ../resources/variables/test_data1.py                    ${crt_environment}     create_case
    Login To Salesforce         ${persona_username}
    #Create a New Case Record    ${subject}                  ${description}              ${account}             ${contact}    ${priority}    ${caseorigin}
    Create a New Case Record    ${CaseTable.Subject}                 ${CaseTable.Description}             ${account}             ${contact}    ${CaseTable.Priority}    ${CaseTable.CaseOrigin}
    Validate the Case using the generated CaseNumber        ${sfbaseurl}                ${newcasenumber}
    Validate a Case Record Using SOQL Query                 ${newcasenumber}            ${CaseTable.Description}            ${CaseTable.CaseOrigin}                      
    