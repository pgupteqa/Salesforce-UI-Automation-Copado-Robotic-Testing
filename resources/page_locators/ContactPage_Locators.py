class ContactPage_Locators(object):

    def __init__(self):
        pass

    def get_variable(self):

        LOCATORS = {

            "ContactNewButtonLocator": "xpath=//button[@name='NewContact']",
            "FirstNameInputFieldLocator": "xpath=//input[@name='firstName']",
            "LastNameInputFieldLocator": "xpath=//input[@name='lastName']",
            "ContactSaveButtonLocator": "xpath=//button[@name='SaveEdit']"

        }

        return LOCATORS