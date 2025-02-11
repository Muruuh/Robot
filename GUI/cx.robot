*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://10.12.25.69/custcare_cu/login
${BROWSER}        Chrome
${USERNAME}       MUNKHMURUN
${PASSWORD}       Muruu0729!
${OK_BUTTON}      name:fromLegalNotice
${USERNAME_FIELD}  id:j_username
${PASSWORD_FIELD}  id:j_password
${CUSTOMER_CONTRACTS_LINK}  xpath=//a[contains(@class, 'vtNodeLink') and contains(text(), 'Customer contracts')]
${SEARCH_LINK}  css=a.vtLeafLink[href*='SearchForContractSU']
${RESOURCE_NO_INPUT}  id:RESOURCENO


*** Test Cases ***
Login and Search Customer Contract
    [Documentation]  Tests login and interaction with customer contracts
    Open Browser to Login Page
    Accept Legal Notice
    Enter Credentials and Login
    Expand Customer Contracts Section
    Navigate to Search Page
    Input Resource Number
    Click Expand Button to Enter Contract Details
    Change Status of Contract
    [Teardown]  Close Browser

*** Keywords ***
Open Browser to Login Page
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed  0.2

Accept Legal Notice
    Wait Until Element Is Visible  ${OK_BUTTON}
    Click Element  ${OK_BUTTON}
    Wait Until Element Is Visible  ${USERNAME_FIELD}

Enter Credentials and Login
    Input Text  ${USERNAME_FIELD}  ${USERNAME}
    Input Password  ${PASSWORD_FIELD}  ${PASSWORD}
    Press Keys  None  RETURN

Expand Customer Contracts Section
    Wait Until Element Is Visible  ${CUSTOMER_CONTRACTS_LINK}  timeout=20
    Click Element  ${CUSTOMER_CONTRACTS_LINK}
    Sleep  0.2  # Adjust based on actual UI response
    Wait Until Element Is Visible  ${SEARCH_LINK}  timeout=20

Navigate to Search Page
    Wait Until Element Is Visible  ${SEARCH_LINK}  timeout=20
    Click Element  ${SEARCH_LINK}
    Wait Until Element Is Visible  ${RESOURCE_NO_INPUT}  timeout=20

Input Resource Number
    Input Text  ${RESOURCE_NO_INPUT}  97699769807
    Press Keys  ${RESOURCE_NO_INPUT}  RETURN
    Wait Until Element Is Visible  xpath=//a[contains(@class, 'DATblTDALinkTxt')]  timeout=50
    Click Element  xpath=//a[contains(@class, 'DATblTDALinkTxt')]

Click Expand Button to Enter Contract Details
    Wait Until Element Is Visible  xpath=//a[contains(@class, 'DATreeItemLink') and contains(@onclick, 'loadAndReplaceDivs')]
    Click Element  xpath=//a[contains(@class, 'DATreeItemLink') and contains(@onclick, 'loadAndReplaceDivs')]
    Sleep  2

Change Status of Contract
    Wait Until Element Is Visible  id=ContractOverviewMainForm_formTag_ServicesStatusChangeButton  timeout=20
    Click Element  id=ContractOverviewMainForm_formTag_ServicesStatusChangeButton
    Sleep  2
