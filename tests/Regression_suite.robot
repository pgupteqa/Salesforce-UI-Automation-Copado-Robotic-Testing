*** Settings ***
Resource                        ../resources/keywords/common.resource
Resource                        ../resources/variables/gettestdata.resource
Resource                        ../resources/keywords/Account_Keywords.resource
Resource                        ../resources/keywords/Contact_Keywords.resource
Resource                        ../resources/keywords/Case_Keywords.resource

Suite Setup                     Run Keywords                Setup Browser               Login to Salesforce Org as AdminUser
Test Setup                      Get Test Data
Suite Teardown                  End Suite


*** Test Cases ***
Verify the User Can Create a New Account and Contact Record
    [Documentation]             This keyword is used to create a new account and contact using the soql query and random test data
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke
    Create a New Account using API                          ${accountname}              ${Industry}
    Verify Account Record       ${accountname}
    #create a new contact record
    Create a New Contact Record                             ${lastname}
    Verify Contact Record       ${lastname}
    Log To Console              ${CURDIR}
Verify a New Case Creation on a Contact
    [Documentation]             Agent user can create a new case with required Fields
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke    ${crt_environment}_case_regression
    Create a New Case Record    ${subject}                  ${description}              ${account}                  ${contact}    ${priority}              ${caseorigin}
    Validate the Case using the generated CaseNumber        ${sfbaseurl}                ${newcasenumber}
    Validate a Case Record Using SOQL Query                 ${newcasenumber}            description                 priority      subject                  caseorigin

Verify a New Case Creation on a Contact using Data Tables
    [Documentation]             Agent user can create a new case with required Fields
    [Tags]                      ${crt_environment}_regression                           ${crt_environment}_smoke    ${crt_environment}_case_regression_datatable
    Create a New Case Record    ${CaseTable.Subject}        ${CaseTable.Description}    ${account}                  ${contact}    ${CaseTable.Priority}    ${CaseTable.CaseOrigin}
    Validate the Case using the generated CaseNumber        ${sfbaseurl}                ${newcasenumber}