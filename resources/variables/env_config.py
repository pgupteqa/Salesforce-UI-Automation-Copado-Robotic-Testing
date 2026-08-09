dev_env = {'sf_base_url': 'https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com'}
qa_env = {'sf_base_url': 'https://orgfarm-0eaed58a8f-dev-ed.develop.my.salesforce.com'}

def get_variables(env):
    if env == 'dev_env':
        return dev_env
    elif env == 'qa_env':
        return qa_env
    else:
        return dev_env