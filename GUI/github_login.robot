*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${URL}      https://github.com/login
${BROWSER}  Chrome
${USERNAME}    Muruuh  # Replace with your GitHub username
${PASSWORD}    Muruu0729  # Replace with your GitHub password

*** Test Cases ***
Login to GitHub
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=login_field    # Wait for the username field to load
    Input Text    id=login_field    ${USERNAME}           # Enter username
    Input Text    id=password       ${PASSWORD}           # Enter password
    Wait Until Element Is Visible    name=commit          # Wait for the login button
    Click Button    name=commit                           # Click the login button
    Sleep    60s                                           # Wait for the login process to complete
    Page Should Contain    Dashboard                     # Verify login success by checking for a unique element on the logged-in page
    Close Browser