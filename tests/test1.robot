*** Settings ***
Documentation  Add a computer to the database
Library     SeleniumLibrary
Library    Screenshot
Library    OperatingSystem

*** Variables ***
${URL}      http://computer-database.gatling.io/computers/new
${Company_Name}    Sony

*** Test Cases ***
Browser setup
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Select Company    ${Company_Name}
    Page Should Contain  ${Company_Name}
    Take Screenshot
    Close Browser

*** Keywords ***
Select Company
    [Arguments]    ${company_name}
    Select From List By Label    id=company    ${company_name}
