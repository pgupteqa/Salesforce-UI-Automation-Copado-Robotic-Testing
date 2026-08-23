*** Settings ***
Library                         ../page_locators/ContactPage_Locators.py
Resource                        common.resource
Resource                        Account_Keywords.resource

*** Keywords ***

Create a New Contact Record
    [Documentation]             This Keyword will create the contact record on the related account
    [Arguments]                 ${lastname}                 ${accountid}= ${account_id}
    Import Variables            ../../resources/variables/test_data1.py           ${crt_environment}          create_contact
    ${contact_random_string}    Get Random String with Numbers
    Set Suite Variable          ${contact_random_string}
    ${contact_id}               CreateRecord                Contact               LastName=${lastname}-${contact_random_string}         AccountId=${accountid}
    Set Suite Variable          ${contact_id}

Verify Contact Record
    [Documentation]             This keyword will verify the account record is created
    Import Variables            ../../resources/variables/env_config.py           ${crt_environment}
    Import Variables            ../../resources/variables/test_data1.py           ${crt_environment}          create_contact
    Set Global Variable         ${sf_org_url}               ${sf_org_url}
    GoToRecord                  ${contact_id}               url=${sf_org_url}
    VerifyText                  ${lastname}-${contact_random_string}