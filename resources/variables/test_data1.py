def get_variable(environment, scenario_variable):
 
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
        }
    }

    variable_name = f"{environment.lower()}.{scenario_variable}"
    data = data_map.get(variable_name, {})

    return {
        f"${{{key}}}": value
        for key, value in data.items()
    }