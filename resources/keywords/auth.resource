*** Settings ***
Resource    common.resource

*** Keywords ***
Login To Salesforce
    [Documentation]        Login to the SF org using connected app
    [Arguments]            ${username}    ${environment}=${EMPTY}
    Run Keyword If         '${environment}'!='${EMPTY}'    Set Global Variable    ${crt_environment}    ${environment}
    Import Variables       ${EXECDIR}/resources/variables/env_config.py           ${crt_environment}
    Set Global Variable    ${sf_base_url}                        ${sf_base_url}
    Log To Console         ${sf_base_url}
    GoTo                   ${sf_base_url}
    JwtAuthenticate         ${consumer_key}             ${persona_username}         ${server_key}
    JwtLogin                /lightning/page/home
    LaunchApp               Service
    VerifyText              Service
