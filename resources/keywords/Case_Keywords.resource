*** Settings ***
Resource                        common.resource
Resource                        ../page_locators/CasePageLocators.resource

*** Keywords ***
Create a New Case Record
    [Documentation]             This keyword will creates an new case record
    [Arguments]                 ${subject}                  ${description}              ${account}                  ${contact}           ${priority}          ${caseorigin}
    ClickText                   Case
    ClickElement                ${CASE_NEW_BUTTON}
    ComboBox                    Search Contacts...          ${contact}
    ComboBox                    Search Accounts...          ${account}
    PickList                    Case Origin                 ${caseorigin}
    PickList                    Priority                    ${priority}
    ScrollTo                    Additional Information
    ${random_num}               Get Random String with Numbers
    TypeText                    ${CASE_SUBJECT}             ${subject}-Ref-{random_num}
    TypeText                    Description                 ${description}
    ClickElement                ${CASE_SAVE_BUTTON}
    #Get casenumber into a variable once it is created
    ${newcasenumber}            GetText                     ${CASENUMBER_TOAST}
    Set Suite Variable          ${newcasenumber}

Validate the Case using the generated CaseNumber
    [Documentation]             This keyword will validate the case using the case numbers
    [Arguments]                 ${sforgurl}                 ${casenumber}
    GlobalSearch                ${sforgurl}                 ${casenumber}               Case
    ${casenumberval}            Replace String              ${CASESEARCH_RESULT}        dynamic_value               ${casenumber}
    VerifyElement               ${casenumberval}
    ClickElement                ${casenumberval}
    VerifyText                  ${casenumber}

Validate a Case Record Using SOQL Query
    [Documentation]             This keyword will get the Case record with all fields
    [Arguments]                 ${casenumber}               @{casefields}
    #${expected_values}         Get Variables               ${crt_environment}          create_case
    ${query}                    Set Variable                Select Fields(ALL), Account.Name, Contact.Name from Case Where CaseNumber = '${casenumber}' Limit 100
    ${records}                  QueryRecords                ${query}
    Should Not Be Empty         ${records}[records]         msg=Case '${newcasenumber}' was not found
    ${case_record}              Set Variable                ${records}[records][0]
    FOR                         ${field}                    IN                          @{casefields}
        ${variable_name}=       Set Variable                \${${field}}
        ${expected_value}=      Get Variable Value          ${variable_name}
        #${expected_value}=     Get From Dictionary         ${expected_values}          ${field}
        Should Not Be Equal     ${expected_value}           ${None}                     msg=Test data variable '${field}' was not found
        ${field_map}            Create Dictionary           subject=Subject             description=Description     priority=Priority    caseorigin=Origin
        ${sf_field}             Get From Dictionary         ${field_map}                ${field}                    default=${field}
        ${actual_value}         Set Variable                ${case_record}[${sf_field}]
        Log To Console          ${field} | Expected: ${expected_value} | Actual: ${actual_value}
        Should Be Equal As Strings                          ${actual_value}             ${expected_value}           msg=Validation failed for field '${field}'
    END


