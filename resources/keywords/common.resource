*** Settings ***
Library    QForce
Library    QWeb
Library    Collections
Library    String
Library    OperatingSystem
#Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Setup Browser
    ${is_live_testing}          Run Keyword And Return Status    Directory Should Not Exist        path=${EXECDIR}/%{SCRIPTS}
    Log To Console              ${is_live_testing}
    IF                        ${is_live_testing}
        Set Global Variable     ${ROOTDIR}                       ${EXECDIR}/../..
    ELSE
        Set Global Variable     ${ROOTDIR}                       ${EXECDIR}/%{SCRIPTS}
    END
    Log To Console              ${ROOTDIR}
    OpenBrowser                 about:blank                 ${BROWSER}
    MaximizeWindow
    SetConfig                   LineBreak                   ${EMPTY}
    Evaluate                    random.seed()               random
    SetConfig                   DefaultTimeout              20s
    #adds a delay of 0.3sec between keywords. This is helpful in cloud with limited resources
    SetConfig                   Delay                       0.3

End Suite
    Close All Browsers
