*** Settings ***
Library    ServiceChecker.py

*** Variables ***
${SERVICE_NAME}    nginx    # Replace with your service name

*** Test Cases ***
Check Service Status Using Custom Library
    [Tags]    Windows   # Add the 'Windows' tag here
    ${status}=    Get Service Status    ${SERVICE_NAME}
    Log    Service Status: ${status}
    Run Keyword If    '${status}' not in ['active', 'Running']    Fail    Service ${SERVICE_NAME} is not running!
