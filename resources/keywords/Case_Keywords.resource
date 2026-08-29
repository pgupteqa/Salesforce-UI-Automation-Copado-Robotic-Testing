*** Settings ***
Library                   ../page_locators/ContactPage_Locators.py
Resource                  common.resource

*** Keywords ***
Create a New Case Record
    [Documentation]       This keyword will creates an new case record
    [Arguments]           ${subject}                  ${description}          ${account}       ${contact}          ${priority}    ${caseorigin}
    ClickText             Case
    ClickElement          ${CASE_NEW_BUTTON}
    ComboBox              Search Contacts...          ${contact}
    ComboBox              Search Accounts...          ${account}
    PickList              Case Origin                 ${caseorigin}
    PickList              Priority                    ${priority}
    ScrollTo              Additional Information
    TypeText              ${CASE_SUBJECT}             ${subject}
    TypeText              ${CASE_DESCRIPTION}         ${description}
    ClickElement          ${CASE_SAVE_BUTTON}
    #Get casenumber into a variable once it is created
    ${newcasenumber}      GetText                     ${CASENUMBER_TOAST}
    Set Suite Variable    ${newcasenumber}

Validate the Case using the generated CaseNumber
    [Documentation]       This keyword will validate the case using the case numbers
    [Arguments]           ${sforgurl}
    GlobalSearch          ${sforgurl}                 ${newcasenumber}        Case
    ${casenumberval}      Replace String              ${CASESEARCH_RESULT}    dynamic_value    ${newcasenumber}
    VerifyElement         ${casenumberval}
    ClickElement          ${casenumberval}
    VerifyText            ${newcasenumber}

