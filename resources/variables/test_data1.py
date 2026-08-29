def get_variables(environment, scenario_variable):
 
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
            "account": "Test Automation CRT-26",
            "contact": "TestAutomationCRT Contact 001",
            "subject": "Unable to access billing invoice",
            "description": "Customer reports a 404 error when downloading the latest invoice PDF from the client portal.",
            "priority": "High",
            "caseorigin": "Web"
        }
    }

    variable_name = f"{environment.lower()}.{scenario_variable}"
    data = data_map.get(variable_name, {})
    
    return data