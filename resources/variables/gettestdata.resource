*** Keywords ***
Get Test Data
    [Documentation]     Declear all test data variable keys using import variable keyword
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py       ${crt_environment}    create_account
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py       ${crt_environment}    create_contact
    Import Variables    ${ROOTDIR}/data/testdata/stgenv_testdata.py       ${crt_environment}    create_case