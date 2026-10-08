*** Keywords ***
Get Test Data
    [Documentation]     Add all test data file path into this variable
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py            ${crt_environment}    create_account
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py            ${crt_environment}    create_contact
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py            ${crt_environment}    create_case