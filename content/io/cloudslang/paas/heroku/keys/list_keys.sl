####################################################
#!!
#! @description: Performs a REST API call to list the existing SSH keys of the user.
#! @input username: Heroku username
#!                  example: 'someone@mailprovider.com'
#! @input password: Heroku password used for authentication
#! @output return_result: response of the operation in case of success, error message otherwise
#! @output error_message: return_result if status_code is not '200'
#! @output return_code: '0' if success, '-1' otherwise
#! @output status_code: code returned by the operation
#!!#
####################################################

namespace: io.cloudslang.paas.heroku.keys

imports:
  rest: io.cloudslang.base.network.rest

flow:
  name: list_keys
  inputs:
    - username
    - password

  workflow:
    - list_keys:
        do:
          rest.http_client_get:
            - url: "https://api.heroku.com/account/keys"
            - username
            - password
            - headers: "Accept:application/vnd.heroku+json; version=3"
            - content_type: "application/json"

        publish:
          - return_result
          - error_message
          - return_code
          - status_code
  outputs:
    - return_result
    - error_message
    - return_code
    - status_code