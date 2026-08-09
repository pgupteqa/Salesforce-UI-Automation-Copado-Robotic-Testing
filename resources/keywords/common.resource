*** Settings ***
Library    QForce
Library    QWeb
Library    Collections
Library    String
Library    OperatingSystem
#Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${BROWSER}

*** Keywords ***
Setup Browser
    OpenBrowser                 about:blank                 ${BROWSER}
    MaximizeWindow
    SetConfig                   LineBreak                   ${EMPTY}
    Evaluate                    random.seed()               random
    SetConfig                   DefaultTimeout              20s
    #adds a delay of 0.3sec between keywords. This is helpful in cloud with limited resources
    SetConfig                   Delay                       0.3

End Suite
    Close All Browsers
