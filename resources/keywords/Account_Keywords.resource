*** Settings ***
Library                    ../page_locators/AccountPage_Locators.py
Resource                   common.resource

*** Keywords ***
Create a New Account using API
    [Documentation]        This keyword will creates an new account using the soql query
    [Arguments]            ${account_name}=TestAccount 004                         ${industry_name}=Banking
    ${account_id}          CreateRecord                Account                     Name=${account_name}        Industry=${industry_name}
    Set Global Variable    ${account_id}

Verify Account Record
    [Documentation]        This keyword will verify the account record is created
    Import Variables       ../../resources/variables/env_config.py                 ${crt_environment}
    Set Global Variable    ${sf_org_url}               ${sf_org_url}
    GoToRecord             ${account_id}               url=${sf_org_url}
    VerifyText             TestAccount 004

Create a New Contact Record
    [Documentation]        This Keyword will create the contact record on the related account
    [Arguments]            ${last_name}=User004            ${accountid}=${account_id}
    ${contact_id}          CreateRecord                Contact                     ${last_name}               ${accountid}
    Set Global Variable    ${contact_id}

Verify Contact Record
    [Documentation]        This keyword will verify the account record is created
    Import Variables       ../../resources/variables/env_config.py                 ${crt_environment}
    Set Global Variable    ${sf_org_url}               ${sf_org_url}
    GoToRecord             ${contact_id}               url=${sf_org_url}
    VerifyText             User004