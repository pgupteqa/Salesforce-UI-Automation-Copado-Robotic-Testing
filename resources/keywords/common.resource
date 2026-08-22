*** Settings ***
Library                       QForce
Library                       QWeb
Library                       Collections
Library                       String
Library                       OperatingSystem
#Library                      SeleniumLibrary
Library                       DateTime

*** Variables ***
${BROWSER}                    ${browser}

*** Keywords ***
Setup Browser
    ${is_live_testing}        Run Keyword And Return Status                           Directory Should Not Exist    path=${EXECDIR}/%{SCRIPTS}
    Log To Console            ${is_live_testing}
    IF                        ${is_live_testing}
        Set Global Variable                               ${ROOTDIR}                  ${EXECDIR}/../..
    ELSE
        Set Global Variable                               ${ROOTDIR}                  ${EXECDIR}/%{SCRIPTS}
    END
    Log To Console            ${ROOTDIR}
    OpenBrowser               about:blank                 ${BROWSER}
    MaximizeWindow
    SetConfig                 LineBreak                   ${EMPTY}
    Evaluate                  random.seed()               random
    SetConfig                 DefaultTimeout              20s
    #adds a delay of 0.3sec between keywords. This is helpful in cloud with limited resources
    SetConfig                 Delay                       0.3

End Suite
    Close All Browsers

Get Random String with CurrentDate
    [Documentation]           Generates the Random String with Current Date
    ${current_date_val}       Get Current Date            result_format=%d-%m-%Y
    ${random_string}          Generate Random String      5                           [Letters][Numbers]
    ${random_string_value}    Set Variable                ${random_string}-${current_date_val}
    RETURN                    ${random_string_value}                    
