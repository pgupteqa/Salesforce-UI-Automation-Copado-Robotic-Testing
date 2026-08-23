stg_env = {'sf_base_url': 'https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com'}
uat_env = {'sf_base_url': 'https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com'}
prod_env = {'sf_base_url': 'https://login.salesforce.com', 'sf_org_url': 'https://orgfarm-0eaed58a8f-dev-ed.develop.lightning.force.com/'}

def get_variables(env):
    if env == 'stg_env':
        return stg_env
    elif env == 'uat_env':
        return uat_env
    elif env == 'prod_env':
        return prod_env
    else:
        return stg_env