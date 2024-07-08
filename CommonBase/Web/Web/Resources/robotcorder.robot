*** Settings ***
Library     SeleniumLibrary
Library    Collections
Library    String
Library    ../../../Utilities/user_keywords.py
Resource  ../../../../Web/RR/Resources/Login/login_keywords.robot

#Test Setup      Launch Application
#Test Teardown   Close Browser
#

*** Test Cases ***
Verify Autofilled data on donation form
    Launch Application
    Click Element    xpath=(//span[@class="nav-text"])[3]
    Click Element    xpath=(//span[@class="nav-text"])[38]
    Select From List By Value    //select[@name="foundation"]    Access to Water
    Input Text    //input[@name="firstName"]    jldsgj
    Input Text    //input[@name="lastName"]    nsfjdhsg
    Input Text    //input[@name="email"]    hjkbmn@gmail.com
    Input Text    //input[@name="mobileNumber"]    9837483657
    Input Text    //input[@name="dateOfBirth"]    0001-09-12
    Input Text    //input[@name="dateOfBirth"]    0019-09-12
    Input Text    //input[@name="dateOfBirth"]    0199-09-12
    Input Text    //input[@name="dateOfBirth"]    1999-09-12
    Select From List By Value    //select[@name="state"]    Maharashtra
    Input Text    //input[@name="city"]    pune
    Input Text    //input[@name="panNumber"]    NNJPS7234S
    Input Text    //textarea[@name="address"]    snbdkas

Verify Lucknow super giants players
    Open Browser    https://www.lucknowsupergiants.in/      chrome
    Click Element    xpath=(//span[@class="nav-text"])[2]
    Click Element    //li[@id="tab0"]
    Click Link    //a[@title="View Profile"]
    Click Element    xpath=(//span[@class="btn-text"])[5]
    Click Element    //button[@class="tab-anchor"]

Verify matches for LSG
    Open Browser    https://www.lucknowsupergiants.in    chrome
    Maximize Browser Window
    Click Element    xpath=(//span[@class="nav-text"])[3]
    Click Element    //button[text()='I accept']
    Click Link    //a[@href="/schedule-fixtures-results/rajasthan-royals-vs-lucknow-super-giants-rrlko03242024237774"]
    Click Element    //li[@class="tab-name"]
    Click Element    //li[@class="tab-name"]
    Click Element    xpath=(//span)[35]
    Click Element    //div[@class="selected-title"]
    Click Element    //button[@class="list-item"]
    Click Element    //div[@class="filter-section datalayer-filter filter-selected"]
    Click Element    //button[@class="btn btn-resetfilter"]

Verify news feature for LSG
    Open Browser    https://www.lucknowsupergiants.in/    chrome
    Click Element    //button[@class="nav-anchor"]
    Click Element    //p[@class="nav-text"]
    Click Element    //img[@class="lazyload ls-is-cached lazyloaded "]
    Click Element    //button[@class="social-icon icon-twitter"]

Verify Profile details Filling Up
   Open Browser    https://www.lucknowsupergiants.in/    chrome
    Click Element    //button[@class="btn btn-toggle-profile"]
    Maximize Browser Window
    Input Text    //input[@name="First Name"]    pallavi
    Input Text    //input[@name="Last Name"]    sgdjs
    Input Text    //input[@name="registerEmail"]    abc@gmail.com
    Input Text    //input[@name="password"]    ***
    Click Element    //button[@class="btn-site btn-otp"]
    Input Text    //input[@name="regConfirmPassword"]    ***
    Input Text    //input[@name="password"]    ***
    Input Text    //input[@name="regConfirmPassword"]    ***
    Input Text    //input[@name="Mobile Number"]    9307338501
    Click Element    xpath=(//span[@class="checkmark"])[2]
    Click Element    //span[@class="checkmark"]
    Click Element    xpath=(//span[@class="btn-text"])[6]