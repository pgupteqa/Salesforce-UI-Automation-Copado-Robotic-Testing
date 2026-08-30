*** Settings ***
Resource                        common.resource
Resource                        ../page_locators/AccountPage_locator.resource


*** Keywords ***
Create a New Account using API
    [Documentation]             This keyword will creates an new account using the soql query
    [Arguments]                 ${accountname}              ${Industry}
    ${account_random_string}    Get Random String with CurrentDate
    Set Suite Variable          ${account_random_string}
    Log To Console              ${account_random_string}
    ${account_id}               CreateRecord                Account                     Name=${account_name}-${account_random_string}         Industry=${Industry}
    Set Suite Variable          ${account_id}


Verify Account Record
    [Documentation]             This keyword will verify the account record is created
    [Arguments]                 ${accountname}
    Import Variables            ../../resources/variables/env_config.py                 ${crt_environment}
    Set Suite Variable          ${sf_org_url}               ${sf_org_url}
    GoToRecord                  ${account_id}               url=${sf_org_url}
    VerifyText                  ${accountname}-${account_random_string}