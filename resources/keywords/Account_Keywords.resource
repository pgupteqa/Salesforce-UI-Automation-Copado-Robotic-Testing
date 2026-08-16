*** Settings ***
Library                    ../page_locators/AccountPage_Locators.py
Resource                   common.resource

*** Keywords ***
Create a New Account using API
    [Documentation]        This keyword will creates an new account using the soql query
    [Arguments]            ${account_name}=TestAccount 003             ${industry_name}=Banking
    ${account_id}          CreateRecord                Account             Name=${account_name}    Industry=${industry_name}
    Set Global Variable    ${account_id}

Verify Account Record
    [Documentation]    This keyword will verify the account record is created
    Import Variables       ../../resources/variables/env_config.py           ${crt_environment}
    Set Global Variable    ${sf_base_url}              ${sf_base_url}
    GoToRecord         ${account_id}    url=${sf_base_url}
    VerifyText         TestAccount 002
