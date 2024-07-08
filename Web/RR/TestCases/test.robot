*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://stg-rr.sportz.io

*** Test Cases ***
Open Site In Chrome
    Open Browser    ${URL}    chrome
    [Teardown]    Close Browser

Open Site In Firefox
    Open Browser    ${URL}    firefox
    [Teardown]    Close Browser

Open Site In Chrome
    Open Browser    ${URL}    chrome
    [Teardown]    Close Browser

Open Site In Firefox
    Open Browser    ${URL}    firefox
    [Teardown]    Close Browser

Open Site In Chrome
    Open Browser    ${URL}    chrome
    [Teardown]    Close Browser

Open Site In Firefox
    Open Browser    ${URL}    firefox
    [Teardown]    Close Browser
