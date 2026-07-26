import jwt
import requests
import time
from pathlib import Path

__version__ = '1.0.0'

class SalesforceAuthenticationHandlerLib():
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        pass

    def _get_environment(self, env=None):
        return env.lower()

    def _email_suffix(self):
        if self._get_environment() == 'prod':
            suffix = "add company email extension eg: @abc.com"
        else:
            suffix = "@abc.com" + self._get_environment()
        return suffix

    #jwt header and body
    def _process_payload(self, data_map):
        issued_at = int(time.time())
        expiration_time = issued_at + 300  # validate 5 min
        data_map['username_formatted'] = data_map['username'] + self._email_suffix()
        data_map['grant_type'] = "urn:ietf:params:oauth:grant-type:jwt-bearer"
        payload = {
            'iss': data_map.get(self._get_environment() + ".consumer_key"),
            'sub': data_map.get('username_formatted'),
            'aud': data_map.get(self._get_environment() + ".endpoint"),
            'exp': expiration_time,
        }
        return payload

    def _get_jwt_token(self,data_map):
        # load key, live session uses /home/services/suite/
        cert_path = Path(data_map.get('cert_path') + self._get_environment() + '-server.key')

        with open(cert_path, 'r') as cert_file:
            cert_key = cert_file.read()

        # encode jwt with rs256
        jwt_token = jwt.encode(self._process_payload(data_map), cert_key, algorithm='RS256')
        return jwt_token

    def _get_session_token(self, data_map):
        data_map['assertion'] = self._get_jwt_token(data_map)
        token_url = data_map.get(self._get_environment() + ".endpoint") + "services/oauth2/token"
        params = {
            'grant_type': "urn:ietf:params:oauth:grant-type:jwt-bearer",
            'assertion': data_map.get('assertion'),

        }

    # get access token
        response = requests.post(token_url, data=params)
        response_data = response.json()

        if response.status_code == 200:
            access_token = response_data['access_token']
        else:
            access_token = None
        print(f"Failed to generate access token: {response_data}")

        return access_token

    def get_salesforce_session_token(self,user,enviornment, cert_path):
        """
        Keyword to get salesforce session token and return session token
        """

        global env
        env = enviornment
        data_map = {
            'uat.endpoint': "https://test.salesforce.com/",
            'uat.consumenr_key': "",
            'env': env, 'username': user, 'cert_path': cert_path
        }

        session_token = self._get_session_token(data_map)
        return session_token

