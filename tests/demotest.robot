*** Settings ***
Library                     QForce
Library                     QWeb
Library                     Collections
Library                     ../resources/variables/test_data.py
Resource                    ../resources/keywords/auth.resource
Resource                    ../resources/keywords/common.resource

Variables                   ../resources/variables/test_data_exp.py

Suite Setup                 Setup Browser
Suite Teardown              End Suite


*** Variables ***
${orgurl}                   https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com

*** Test Cases ***
Login To salesforce
    [Documentation]         This keyword is used to Login to the salesforce Via JWT Login
    GoTo                    ${orgurl}
    JwtAuthenticate         ${consumer_key}             ${persona_username}         ${server_key}
    JwtLogin                /lightning/page/home
    VerifyText              Service

    #00001002
    ${query}                Set Variable                Select Id, Subject, Status from Case Where CaseNumber = '00001002'
    ${records}              QueryRecords                ${query}
    Log To Console          ${records}[records][0][Id]

    ${data}                 Get Input Data
    @{substatus_values}=    Get Dictionary Keys         ${data}

    FOR                     ${status_val}               IN                          @{substatus_values}
        ${expected}=        Get From Dictionary         ${data}                     ${status_val}
        Log To Console      Sub Status:${status_val}
        Log To Console      Sub Status:${expected}
    END

    #Second using python file as dict
    ${dict_keys}            Get Dictionary Keys         ${CASE_DATA}
    FOR                     ${key}                      IN                          @{dict_keys}
        ${value}=           Get From Dictionary         ${CASE_DATA}                ${key}
        Log To Console      Sub Status: ${key}
        Log To Console      Expected Value: ${value}
    END

