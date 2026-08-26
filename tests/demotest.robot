*** Settings ***
Library                         ../resources/variables/test_data.py
Resource                        ../resources/keywords/auth.resource
Resource                        ../resources/keywords/common.resource
Resource                        ../resources/keywords/Account_Keywords.resource
Resource                        ../resources/keywords/Contact_Keywords.resource

Variables                       ../resources/variables/test_data_exp.py

Suite Setup                     Setup Browser
Suite Teardown                  End Suite



*** Test Cases ***
Login To salesforce and Launch Service Application
    [Documentation]             This keyword is used to Login to the salesforce Via JWT Login
    Import Variables            ../resources/variables/test_data1.py                 ${crt_environment}     create_account
    Login To Salesforce         ${persona_username}
    Create a New Account using API                          ${accountname}              ${Industry}
    Verify Account Record       ${accountname}
    Import Variables            ../resources/variables/test_data1.py                 ${crt_environment}     create_contact
    Create a New Contact Record                             ${lastname}
    Verify Contact Record       ${lastname}

    #00001002
    ${query}                    Set Variable                Select Id, Subject, Status from Case Where CaseNumber = '00001002'
    ${records}                  QueryRecords                ${query}
    Log To Console              ${records}[records][0][Id]

    ${data}                     Get Input Data
    @{substatus_values}=        Get Dictionary Keys         ${data}

    FOR                         ${status_val}               IN                          @{substatus_values}
        ${expected}=            Get From Dictionary         ${data}                     ${status_val}
        Log To Console          Sub Status:${status_val}
        Log To Console          Sub Status:${expected}
    END

    #Second using python file as dict
    ${dict_keys}                Get Dictionary Keys         ${CASE_DATA}
    FOR                         ${key}                      IN                          @{dict_keys}
        ${value}=               Get From Dictionary         ${CASE_DATA}                ${key}
        Log To Console          Sub Status: ${key}
        Log To Console          Expected Value: ${value}
    END

