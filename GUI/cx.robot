*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

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
${CONTRACT_EXPAND_BUTTON}  xpath=//a[contains(@class, 'DATreeItemLink') and contains(@onclick, 'loadAndReplaceDivs')]
${STATUS_DROPDOWN}  id=STATUS
${REASON_DROPDOWN}  id=REASON
${OK_BUTTON_ID}  id=servicesStatusChange_formTag_SuOkButton

*** Variables ***
# Test Case 1
@{RESOURCE_NUMBERS_CASE_1}  97699769807

# Test Case 2
@{RESOURCE_NUMBERS_CASE_2}  97699969797

*** Test Cases ***
Run Case 1 Loop with Different Resource Numbers
    [Documentation]  Loops through a set of resource numbers (Case 1)
    FOR  ${i}  IN  @{RESOURCE_NUMBERS_CASE_1}  
        Login and Search Customer Contract  ${i}  
        Change Status of Contract
        Log  Iteration for ${i} in Case 1 completed
        Sleep  2  
    END

Run Case 2 Loop with Different Resource Numbers
    [Documentation]  Loops through a different set of resource numbers (Case 2)
    FOR  ${i}  IN  @{RESOURCE_NUMBERS_CASE_2}  
        Login and Search Customer Contract  ${i}  
        Change Status of Contract
        Log  Iteration for ${i} in Case 2 completed
        Sleep  2 
    END

*** Keywords ***
Login and Search Customer Contract
    [Arguments]  ${resource_number}  
    Open Browser to Login Page
    Accept Legal Notice
    Enter Credentials and Login
    Expand Customer Contracts Section
    Navigate to Search Page
    Input Resource Number  ${resource_number} 
    Click Expand Button to Enter Contract Details

Change Status of Contract
    Wait Until Element Is Visible  id=ContractOverviewMainForm_formTag_ServicesStatusChangeButton  timeout=20
    Click Element  id=ContractOverviewMainForm_formTag_ServicesStatusChangeButton
    Wait Until Element Is Visible  ${STATUS_DROPDOWN}  timeout=20
    Select From List By Value  ${STATUS_DROPDOWN}  2
    Wait Until Element Is Visible  ${REASON_DROPDOWN}  timeout=20
    Select From List By Value  ${REASON_DROPDOWN}  1 
    # Wait Until Element Is Visible  ${OK_BUTTON_ID}  timeout=20  "Don't comment. Clear!"!!!!!!!!!!!!!!!!!
    # Click Element  ${OK_BUTTON_ID}   "Don't comment. Clear!"!!!!!!!!!!!!!!!!!
    Sleep  2 

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
    Sleep  0.2  
    Wait Until Element Is Visible  ${SEARCH_LINK}  timeout=20

Navigate to Search Page
    Wait Until Element Is Visible  ${SEARCH_LINK}  timeout=20
    Click Element  ${SEARCH_LINK}
    Wait Until Element Is Visible  ${RESOURCE_NO_INPUT}  timeout=20

Input Resource Number
    [Arguments]  ${resource_number}
    Input Text  ${RESOURCE_NO_INPUT}  ${resource_number}
    Press Keys  ${RESOURCE_NO_INPUT}  RETURN
    Wait Until Element Is Visible  xpath=//a[contains(@class, 'DATblTDALinkTxt')]  timeout=50
    Click Element  xpath=//a[contains(@class, 'DATblTDALinkTxt')]

Click Expand Button to Enter Contract Details
    Wait Until Element Is Visible  ${CONTRACT_EXPAND_BUTTON}
    Click Element  ${CONTRACT_EXPAND_BUTTON}
    Sleep  2

[Teardown]  Close Browser
    Close Browser
