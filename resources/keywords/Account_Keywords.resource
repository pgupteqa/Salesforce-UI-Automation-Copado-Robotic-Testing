*** Settings ***
Library                         ../page_locators/AccountPage_Locators.py
Resource                        common.resource

*** Keywords ***
Create a New Account using API
    [Documentation]             This keyword will creates an new account using the soql query
    [Arguments]                 ${accountname}              ${Industry}
    ${account_random_string}    Get Random String with Numbers
    Set Suite Variable          ${account_random_string}
    ${account_id}               CreateRecord                Account                     Name=${account_name} ${account_random_string}         Industry=${Industry}
    Set Suite Variable          ${account_id}


Verify Account Record
    [Documentation]             This keyword will verify the account record is created
    [Arguments]                 ${accountname}
    Import Variables            ../../resources/variables/env_config.py                 ${crt_environment}
    Set Global Variable         ${sf_org_url}               ${sf_org_url}
    GoToRecord                  ${account_id}               url=${sf_org_url}
    VerifyText                  ${accountname} ${account_random_string}

Create a New Contact Record
    [Documentation]             This Keyword will create the contact record on the related account
    [Arguments]                 ${last_name}=User005        ${accountid}=${account_id}
    ${contact_id}               CreateRecord                Contact                     LastName=${last_name}       AccountId=${accountid}
    Set Global Variable         ${contact_id}

Verify Contact Record
    [Documentation]             This keyword will verify the account record is created
    Import Variables            ../../resources/variables/env_config.py                 ${crt_environment}
    Set Global Variable         ${sf_org_url}               ${sf_org_url}
    GoToRecord                  ${contact_id}               url=${sf_org_url}
    VerifyText                  User004