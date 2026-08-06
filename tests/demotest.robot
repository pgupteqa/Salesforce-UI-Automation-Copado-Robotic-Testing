*** Settings ***
Library    QForce
Library    QWeb
Resource    ../resources/keywords/auth.resource
Resource    ../resources/keywords/common.resource

Suite Setup    OpenBrowser         about:blank     chrome


*** Variables ***
${orgurl}      https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com

*** Test Cases ***
Login To salesforce
    [Documentation]    This keyword is used to Login to the salesforce Via JWT Login
    GoTo               ${orgurl}
    JwtAuthenticate    ${consumer_key}      ${persona_username}    ${server_key}
    JwtLogin           /lightning/page/home
    VerifyText         Service
    
    #00001002
    ${query}           Set Variable         Select Id, Subject, Status from Case Where CaseNumber = '00001002'
    ${records}         QueryRecords         ${query}
    Log To Console     ${records}[records][0][Id]              