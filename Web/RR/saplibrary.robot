*** Settings ***
Library  SapGuiLibrary
Library    Telnet
Library    SeleniumLibrary

*** Variables ***
${SAP_GUI_SERVER}    localhost
${SAP_GUI_INSTANCE}  00
${SAP_GUI_USERNAME}  your_username
${SAP_GUI_PASSWORD}  your_password

*** Keywords ***

*** Test Cases ***
Login to SAP GUI
    [Documentation]    Tests the login functionality of SAP GUI
    Open Connection    ${SAP_GUI_SERVER}
    ${login_status}    Login    ${SAP_GUI_USERNAME}    ${SAP_GUI_PASSWORD}
    Should Be True    ${login_status}    Login to SAP GUI failed
    ${session_id}    Get Session Id
    Log    Logged in successfully with Session ID: ${session_id}

Logout from SAP GUI
    [Documentation]    Tests the logout functionality of SAP GUI
    Close All Connections
