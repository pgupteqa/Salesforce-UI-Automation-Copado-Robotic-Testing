*** Settings ***
Resource                  common.resource
Resource        ../page_locators/CasePageLocators.resource

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
    ${random_num}         Get Random String with Numbers
    TypeText              ${CASE_SUBJECT}             ${subject}-Ref-{random_num}
    TypeText              Description                 ${description}
    ClickElement          ${CASE_SAVE_BUTTON}
    #Get casenumber into a variable once it is created
    ${newcasenumber}      GetText                     ${CASENUMBER_TOAST}
    Set Suite Variable    ${newcasenumber}

Validate the Case using the generated CaseNumber
    [Documentation]       This keyword will validate the case using the case numbers
    [Arguments]           ${sforgurl}    ${casenumber}
    GlobalSearch          ${sforgurl}                 ${casenumber}        Case
    ${casenumberval}      Replace String              ${CASESEARCH_RESULT}    dynamic_value    ${casenumber}
    VerifyElement         ${casenumberval}
    ClickElement          ${casenumberval}
    VerifyText            ${casenumber}

