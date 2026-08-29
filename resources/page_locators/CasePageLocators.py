class CasePage_Locators(object):

    def __init__(self):
        pass

    def get_variable(self):

        LOCATORS = {

            "CASE_NEW_BUTTON": "xpath=//a[@title='New']",
            "CASE_SUBJECT": "xpath=//input[@name='Subject']",
            "CASE_DESCRIPTION": "xpath=//input[@name='Description']",
            "CASE_SAVE_BUTTON": "xpath=//button[@name='SaveEdit']"

        }

        return LOCATORS