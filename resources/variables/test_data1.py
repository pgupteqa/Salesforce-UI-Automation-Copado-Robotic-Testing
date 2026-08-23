class Test_Data1():

    def __init__(self):
        pass
    
    def _get_environment(self):
        return env.lower()
    
    def get_variable(self, environment, scenario_variable):
        """
        Get scenario Variables
        :return: scenario variables
        """
        global env
        env = environment
        data_map ={
        
        "stg_env.create_account":
        {
            "account_name": "TestAccount",
            "Industry": "Banking"
        },


        'env': env}

        #Read Data map variable
        variable_name = self._get_environment() + '.' + scenario_variable

        if data_map.get(variable_name) != None:
            return data_map.get(variable_name)
        else:
            return data_map.get(scenario_variable)