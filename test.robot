*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://cses.fi/login
${BROWSER}        Chrome
${USERNAME}       Murun
${PASSWORD}       123
${FILE_PATH}      C:\\Users\\munkhmurun\\OneDrive - mobicom\\Desktop\\Munkhmurun\\Code\\a.cpp

*** Test Cases ***
Submit Solution to Weird Algorithm
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    name=nick
    Input Text    name=nick    ${USERNAME}
    Input Password    name=pass    ${PASSWORD}
    Click Button    xpath=//input[@type='submit' and @value='Submit']
    Wait Until Page Contains    CSES Problem Set    10s

    # Navigate to Problem Set
    Click Link    xpath=//a[contains(text(), 'here')]
    Wait Until Page Contains    Weird Algorithm    10s

    # Open Weird Algorithm problem
    Click Link    xpath=//a[@href="/problemset/task/1068"]
    Wait Until Page Contains    Submit    10s

    # Navigate to Submit page
    Wait Until Element Is Visible    xpath=//a[@href="/problemset/submit/1068/"]    10s
    Click Link    xpath=//a[@href="/problemset/submit/1068/"]
    # Wait for the file input element instead of the text
    Wait Until Element Is Visible    xpath=//input[@type='file']    10s

    # Upload and submit solution
    Choose File    xpath=//input[@type='file']    ${FILE_PATH}
    Click Button    xpath=//input[@type='submit' and @value='Submit']
    Wait Until Page Contains    Submission Details    60s
    Close Browser