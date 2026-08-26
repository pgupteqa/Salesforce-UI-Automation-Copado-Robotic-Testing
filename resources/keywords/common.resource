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
    ${current_date_val}       Get Current Date            result_format=datetime
    ${random_string}          Generate Random String      4                           [LOWER]
    ${random_string_value}    Set Variable                Ref-${random_string}-${current_date_val}
    Set Suite Variable        ${random_string_value}
    RETURN                    ${random_string_value}

Get Random String with Numbers
    [Documentation]           Generates the Random String with numbers
    ${random_string_no}       Generate Random String      3                           [Numbers]
    ${random_string}          Generate Random String      2                           [LOWER]
    ${random_string_num}      Set Variable                Ref-${random_string}-${random_string_no}
    Set Suite Variable        ${random_string_num}
    RETURN                    ${random_string_num}
