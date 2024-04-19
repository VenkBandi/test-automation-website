*** Settings ***
Documentation  Add a computer to data base
Library     SeleniumLibrary
Library    Screenshot
Library    OperatingSystem
Library    DateTime
Library    ../resources/resource.py 


*** Variables ***
${URL}      http://computer-database.gatling.io/
${Expected_Message_1}    Failed to refine type : Predicate isEmpty() did not fail.
${Company_Name}    Sony


*** Test Cases ***
Verify Successful addition of new computer
    [documentation]  This test case adds a new computer to the data base
    [tags]  InsertionTesting
    Browser setup
    Check Hompage Elements And Click To Add Computer
    Check For Page Elements In The Form
    Check The Presence of Sony in List
    Without Computer Name
    ${NAME}=    With Computer Name Random Name
    ${Status}=   Check Successful Message    ${NAME}
    Close Browser

*** Keywords ***
Browser setup
    Open Browser   ${URL}  Chrome
    Maximize Browser Window

Check hompage elements and click to add computer
    Wait Until Element Is Visible  id:main  timeout=05
    Click Element    id=add

Check for page elements in the form
    PAGE SHOULD CONTAIN    Computer name
    PAGE SHOULD CONTAIN    Introduced
    Page Should Contain    Discontinued
    Page Should Contain    Company

Check The Presence of Sony in List
    ${Status}=   Select Company    ${Company_Name}
    Run Keyword If    '${status}' == 'True'    Log    Company found

Without computer name
     Input Text    id=name    ${EMPTY}
     Click Button    css=input.btn.primary[value="Create this computer"]
     page should contain   ${EXPECTED_MESSAGE_1}

With Computer Name Random Name
    ${NAME}=    getName     10 
    Input Text    id=name   ${NAME}
    ${introduced_date}=     getDate  0
    Input Text    id=introduced    ${introduced_date}
    ${discontinued_date}=     getDate  7
    Input Text    id=discontinued    ${discontinued_date}
    select from list by label   company    ${Company_Name}
    Click Button    class=btn.primary
    Sleep   2s 
    RETURN   ${NAME}

Check Successful Message
    [Arguments]  ${NAME}
    ${Expected_Message_2}=   getm    ${NAME}
    ${Status}=  Run Keyword And Return Status   Page should contain element   //*[@id="main"]/div[1]    ${Expected_Message_2}
    RETURN    ${Status}

Select Company
    [Arguments]    ${company_name}
    Select From List By Label    id=company    ${company_name}
    ${Status}=   Run Keyword And Return Status  Page Should Contain  ${Company_Name}
    RETURN    ${Status}
    