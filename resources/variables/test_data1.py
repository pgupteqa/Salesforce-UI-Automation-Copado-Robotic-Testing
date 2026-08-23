class Test_Data1():

    def __init__(self):
        pass
    
    #def _get_environment(self):
    #    return env.lower()
    
    def get_variable(self, environment, scenario_variable):
        """
        Get scenario Variables
        
        :return: scenario variables
        """
        #global env
        #env = environment
        data_map ={
        
        "stg_env.create_account":
        {
            "accountname": "TestAccount",
            "Industry": "Banking"
        },

        "stg_env.create_contact":
        {
            "firstname": "TestContact",
            "lastname": "User"
        },

        "stg_env.create_case":
        {
              "subject": "Unable to access billing invoice",
              "description": "Customer reports a 404 error when downloading the latest invoice PDF from the client portal.",
              "priority": "High",
              "origin": "Phone"
        },


        #'env': env
        }

            #Read Data map variable
            #variable_name = self._get_environment() + '.' + scenario_variable

            #if data_map.get(variable_name) != None:
            #    return data_map.get(variable_name)
            #else:
            #    return data_map.get(scenario_variable)
    variable_name = f"{environment.lower()}.{scenario_variable}"
    data = data_map.get(variable_name, {})

    return {
        f"${{{key}}}": value
        for key, value in data.items()
    }