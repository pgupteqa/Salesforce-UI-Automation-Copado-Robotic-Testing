class AccountPage_Locators(object):

    def __init__(self):
        pass

    def get_variable(self):

        LOCATORS = {

            "AccountNewButtonLocator": "xpath=//div[@title='New']",
            "AccountNameInputFieldLocator": "xpath=//input[@name='Name']"
        }

        return LOCATORS