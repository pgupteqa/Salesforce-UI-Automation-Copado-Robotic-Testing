*** Settings ***
Library    QForce
Library    Qweb
Resource    ../resources/keywords/auth.resource
Resource    ../resources/keywords/common.resource

*** Variables ***
${username}    gupte.pratik1992@agentforce.com
${password}    Pra2892pte#
${orgurl}      https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com

*** Test Cases ***
Login To salesforce
    OpenBrowser         about:blank     chrome