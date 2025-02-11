*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
Check GET Request to JSONPlaceholder API
    [Documentation]    Test GET request to public API and verify response
    Create Session    jsonplaceholder    https://jsonplaceholder.typicode.com
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    
    # Basic response validation
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${response.reason}    OK
    
    # Validate response headers
    Dictionary Should Contain Key    ${response.headers}    Content-Type
    Should Contain    ${response.headers["Content-Type"]}    application/json
    
    # Validate response body
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json["userId"]}    1
    Should Be Equal As Numbers    ${json["id"]}        1
    Should Not Be Empty           ${json["title"]}
    Should Not Be Empty           ${json["body"]}
    
    [Teardown]    Delete All Sessions

*** Test Cases ***
Check POST Request to Test API
    [Documentation]    Test POST request with payload
    Create Session    testapi    https://jsonplaceholder.typicode.com
    &{headers}=    Create Dictionary    Content-Type=application/json
    
    ${payload}=    Create Dictionary
    ...    title=xxotestshu
    ...    body=basltestbody
    ...    userId=1
    
    ${response}=    POST On Session    testapi    /posts
    ...    json=${payload}
    ...    headers=${headers}
    
    Should Be Equal As Strings    ${response.status_code}    201
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json["title"]}    xxotestshu
    Should Be Equal As Strings    ${json["body"]}     basltestbody
    Should Be Equal As Numbers    ${json["userId"]}    1
    
    [Teardown]    Delete All Sessions