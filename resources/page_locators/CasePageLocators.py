def get_variable():

    LOCATORS = {

        "CASE_NEW_BUTTON": "xpath=//a[@title='New']",
        "CASE_SUBJECT": "xpath=//input[@name='Subject']",
        "CASE_DESCRIPTION": "xpath=//input[@name='Description']",
        "CASE_SAVE_BUTTON": "xpath=//button[@name='SaveEdit']",
        "CASENUMBER_TOAST": "xpath=//div//span[contains(@class,'toastMessage')]/a",
        "CASESEARCH_RESULT": "xpath=//th//a[contains(text(),'dynamic_value')]"

    }

    return LOCATORS