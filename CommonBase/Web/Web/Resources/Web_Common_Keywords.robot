*** Settings ***
Library     SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${Mobile_num}   9800000001
@{expected player}      SANJU SAMSON  DHRUV JUREL   JOS BUTTLER   KUNAL SINGH RATHORE  TOM KOHLER-CADMORE   fds  fds  dfs  dsf  sdgf  sdsdv    dsgs  sdg  sdf  sdsd  dsg dffs   dsf   dsf   dsf   dsdf   dfds   sdf sdg sdgd sdg sddg sdf sdg sdg sdg sdg
*** Keywords ***
Login With Otp For Web
    [Arguments]     ${Login}   ${Mobile_input}    ${Send_otp_btn}    ${Otp_input}
    Wait Until Element Is Visible    ${Login}   timeout=20s
    Click Element    ${Login}           
    Wait Until Element Is Visible    ${Mobile_input}    timeout=30s
    Input Text    ${Mobile_input}    ${Mobile_num}

Sign Up Details Web
    [Arguments]   ${firstname}  ${lastname}   ${mail}=None     ${mobile_num}=None
    Wait Until Element Is Visible    ${firstname}   timeout=30s
    Input Text    ${firstname}    abcd
    Wait Until Element Is Visible    ${lastname}    timeout=30s
    Input Text    ${lastname}    pqrs
    ${mail_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mail}
    ${mobile_num_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mobile_num}
    Run Keyword If    '${mail_present}'== 'True'  Input Text    ${mail}    abc@gmail.com
    Run Keyword If    '${mobile_num_present}'== 'True'  Input Text    ${mobile_num}    9999999999

squad Verification
    [Arguments]     ${player_card}     ${player_name}    ${Player_role}   @{expected_list}
    Sleep    2
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    2
    @{player_list}=     Get WebElements    ${player_name}
    ${count}=   Get Element Count    ${player_card}
     Log    ${count}
      ${Actual_list}=  Create List
    FOR    ${element}     IN    @{player_list}
        Wait Until Element Is Visible    ${player_name}     timeout=20s
        Element Should Be Visible    ${player_name}
        Element Should Be Visible    ${Player_role}
        ${details}=      Get Text    ${element}
        Log     ${details}
        @{split}=   Split String    ${details}      \n
        Log    @{split}
        ${fullname}=   Evaluate    "${split}[0] ${split}[1]"
        Log    ${fullname}
       Append To List   ${Actual_list}   ${fullname}
       Log    ${Actual_list}
    END
       Lists Should Be Equal    @{expected_list}    ${Actual_list}

player profile verification
    [Arguments]     ${squad}   ${player_Card}  ${dob}      ${name}     ${batting_style}    ${bowling_style}  ${view_profile}=None
    Wait Until Element Is Visible    ${squad}       timeout=20s
    Mouse Over    ${player_Card}
     ${view_profile_present}=    Run Keyword And Return Status    Element Should Be Visible    ${view_profile}
     Run Keyword If    '${view_profile_present}' == 'True'    Click Element    ${view_profile}
    ...    ELSE    Click Element    ${player_Card}
    Wait Until Element Is Visible    ${dob}     timeout=30s
    Element Should Be Visible    ${dob}
    Element Should Be Visible    ${name}
    Element Should Be Visible    ${batting_style}
    Element Should Be Visible    ${bowling_style}

Navigation Keyword
    [Arguments]     ${main_menu}    ${navigation_page}   ${dd_menu}=None
    Wait Until Element Is Visible    ${main_menu}   timeout=30s
    ${dd_menu_present}=  Run Keyword And Return Status   Page Should Contain Element    ${dd_menu}
    Sleep    2s
    Click Element    ${main_menu}
    Sleep    1s
    Run Keyword If    '${dd_menu_present}'== 'True'     Click Element    ${dd_menu}
    Wait Until Element Is Visible    ${navigation_page}     timeout=30s

Scroll Page Down
    [Arguments]    ${end_element}    ${load_more}=None
    WHILE    True
        Sleep    5s
        ${end_element_visible}=    Run Keyword And Return Status   Element Should Be Visible    ${end_element}
        Log    ${end_element_visible}
        Capture Page Screenshot
        Run Keyword If    '${end_element_visible}' == 'True'    Exit For Loop
        Capture Page Screenshot
        Run Keyword If    '${end_element_visible}' != 'True'    scroll down
        ${load_more_visible}=      Run Keyword And Return Status    Element Should Be Visible   ${load_more}
        Sleep    5s
        Run Keyword If    '${load_more_visible}' == 'True'
        ...  Click Element    ${load_more}
    END

Scroll Page Down
    [Arguments]    ${load_more}=None
    Click Element    //button[contains(@data-action,'closeCookie')]
    WHILE    True
            ${status}   Run Keyword And Return Status       Wait Until Element Is Visible   ${load_more}
            IF    ${status} ==True
                Scroll Element Into View   ${load_more}
                Click Element    ${load_more}
                Sleep    2
            ELSE
                 BREAK
            END
    END

Share icon on news and photos
    [Arguments]      ${sharing_apps}   ${share_icon}=None    ${verification_link}=None    ${expected_link}=None
    ${share_icon_visible}   Run Keyword And Return Status    Element Should Be Visible    ${share_icon}
    ${sharing_apps_visible}     Run Keyword And Return Status    Element Should Be Visible    ${sharing_apps}
    Run Keyword If   ' ${share_icon_visible}' == 'True'  Mouse Over     ${share_icon}
    IF  ${share_icon_visible} !=True
        Click Element    ${sharing_apps}
        Sleep    5s
    ELSE
        Wait Until Element Is Visible    ${share_icon}  timeout=20s
         Click Element    ${share_icon}
         Wait Until Element Is Visible    ${sharing_apps}   timeout=20s
        Capture Page Screenshot
    END
    ${sharing_apps_visible1}     Run Keyword And Return Status    Element Should Be Visible    ${sharing_apps}
    Run Keyword If    '${sharing_apps_visible1}' == 'True'       Click Element    ${sharing_apps}


scroll down
    ${scroll_position}=    Execute JavaScript    return window.pageYOffset
    ${previous_position}=    Set Variable    -1
    FOR    ${i}    IN RANGE    1000
        ${scroll_position}=    Evaluate    ${scroll_position} + 50
        Execute JavaScript    window.scrollTo(0, ${scroll_position})
        Sleep    0.5s
        ${current_position}=    Execute JavaScript    return window.pageYOffset
        Run Keyword If    '${current_position}' == '${previous_position}'    Exit For Loop
        ${previous_position}=    Set Variable    ${current_position}
    END
    
Swiper Verification
    [Arguments]     ${right_swiper}     ${left_swiper}  ${card1_content}    ${card2_Content}
    Wait Until Element Is Visible    ${card1_content}    timeout=30s
    Click Element    ${right_swiper}
    Element Should Not Be Visible    ${card1_content}

pagination
    [Arguments]     ${page_num}     ${page1_content}    ${page2_content}
    Wait Until Element Is Visible    ${page1_content}   timeout=30s
    Scroll Element Into View    ${page_num}
    Click Element    ${page_num}
    Element Should Be Visible    ${page2_content}

Page footer links
    [Arguments]     ${footer_xpath}     ${page_Verfication}
    Scroll Element Into View    ${footer_xpath}
    Click Element    ${footer_xpath}
    Wait Until Element Is Visible    ${page_Verfication}    timeout=30s

Verify Navigation To Play Store
    [Arguments]    ${playstore}   ${expected_url}=None
    Wait Until Element Is Visible    ${playstore}    timeout=30s
    Click Element    ${playstore}
    Switch Window    NEW
    ${current_url}=    Get Location
    Should Be Equal As Strings    ${current_url}    ${expected_url}

Verify Table Header Details
   [Arguments]    ${header_text_list}    ${table_header_text_xpath}
   [Documentation]    Takes list of all table headers and common xpath of table header text elements
   @{column_list}    Create List
   Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
   @{table_header}   Get Webelements    ${table_header_text_xpath}
   FOR   ${column_name}    IN    @{table_header}
       ${column_name}     Get Text    ${column_name}
       Append To List    ${column_list}    ${column_name}
   END
   Lists Should Be Equal    ${column_list}    ${header_text_list}


Verify Table Column Details
   [Arguments]    ${column_content_list}    ${column_text_xpath}
   [Documentation]    Takes list of all column values and common xpath of column text elements
   @{column_value_list}    Create List
   Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
   Sleep    2
   @{column_values}   Get Webelements    ${column_text_xpath}
   FOR   ${column_value}    IN    @{column_values}
       ${column_value_text}     Get Text    ${column_value}
       Append To List    ${column_value_list}    ${column_value_text}
   END
   Lists Should Be Equal    ${column_value_list}    ${column_content_list}


Click On The Social Media Icons
   [Arguments]    ${social_media_site}
   [Documentation]    Takes social media site name as argument and verifies the navigation to respective social site page
   Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
   Sleep    2
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   ${social_media_site}    Convert To Upper Case    ${social_media_site}
   IF     '${social_media_site}' == 'TWITTER'
       Scroll Element Into View    //a[contains(@href,'https://twitter.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://twitter.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://twitter.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'FACEBOOK'
       Scroll Element Into View    //a[contains(@href,'https://www.facebook.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.facebook.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.facebook.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'INSTAGRAM'
       Scroll Element Into View    //a[contains(@href,'https://www.instagram.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.instagram.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.instagram.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'YOUTUBE'
       Scroll Element Into View    //a[contains(@href,'https://www.youtube.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.youtube.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.youtube.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   ELSE IF    '${social_media_site}' == 'LINKEDIN'
       Scroll Element Into View    //a[contains(@href,'https://www.linkedin.com')]
       ${site_link}    Get Element Attribute    //a[contains(@href,'https://www.linkedin.com')]    href
       @{web_split}    Split String    ${site_link}     /
       ${name_from_url}   Get From List     ${web_split}    3
       Click Element    //a[contains(@href,'https://www.linkedin.com')]
       Switch Window    locator=new
       ${current_page_url}    Get Location
       @{opened_web_split}    Split String    ${site_link}     /
       ${name_from_opened_url}   Get From List     ${web_split}    3
       Should Be Equal    ${name_from_url}    ${name_from_opened_url}
   END


Click On The Footer Links
   [Arguments]    ${xpath_of_footerlink}
   Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
   Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
   Scroll Element Into View    ${xpath_of_footerlink}
   ${footer_text}   Get Text    ${xpath_of_footerlink}
   Log To Console    ${footer_text}
   Click Element    ${xpath_of_footerlink}
   Page Should Contain    ${footer_text}

Verify Cell Value Verification
   [Arguments]    ${xpath_of_table_shell}    ${cell_value}
   Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
   ${cell_value_text}    Get Text    ${xpath_of_table_shell}
   Should Be Equal    ${cell_value_text}    ${cell_value}




*** Test Cases ***
squad verification
    Open Browser     https://stg-rr.sportz.io/rr-players    Chrome
    Squad Verification    //div[@class="player-wrap"]   //div[@class="player-name"]    //p[@class="role"]     ${expected player}

Player profile verification
    Open Browser    https://www.punjabkingsipl.in/players    Chrome
    Click Element    //span[text()='close']//parent::button
#    player profile verification    //a[normalize-space()="View Profile"]    //span[text()='Players']   //div[@class="player-wrap"]     //p[text()='born']//following-sibling::p[@class="player-meta-value"]    //span[@class="name first-name"]    //p[text()='Batting Style']//following-sibling::p[@class="player-meta-value"]    //p[text()='Bowling Style']//following-sibling::p[@class="player-meta-value"]
    player profile verification     //h1[normalize-space()='Sadda Squad']   //div[@class="squad-wrapper"]   //p[text()='Born']//following-sibling::p[@class="value"]    //div[@class="player-name"]   //p[text()='Batting Style']//following-sibling::p[@class="value"]    //p[text()='Bowling Style']//following-sibling::p[@class="value"]

Scroll down
        Open Browser    https://www.mumbaiindians.com/mi-junior/news    Chrome
        Maximize Browser Window
#        Scroll Page Down    //p[normalize-space()='Official Partners']
#        Scroll Page Down    //p[@class="copyrights"]   //div[@class="action loadmorebutton"]
        Scroll Page Down     //div[@class="action loadmorebutton"]

    Close Browser

naviagtion
        Open Browser     https://stg-rr.sportz.io/games/quiz/home    Chrome
        Navigation Keyword    //span[text()='Fan Zone']    //div[text()='Let’s get QUIZZING!']        //span[text()='QuizzeRR']
#        Navigation Keyword    //span[text()='Home']    //img[@class="web"]

Swiper Verification
            Open Browser    https://www.lucknowsupergiants.in/   Chrome
            Maximize Browser Window
            Swiper Verification    (//div[@class="col-lg-12"]//following-sibling::div[contains(@class, 'swiper-button-next')])[1]    (//div[@class="col-lg-12"]//following-sibling::div[contains(@class, 'swiper-button-prev')])[1]    //*[@id="swiper-wrapper-491d6d654e7dd23b"]/article[1]/div/div[2]/a/h3    //*[@id="swiper-wrapper-38f9589f86b66bf4"]/article[1]/div/div[2]/a/h3

download app Verification
            Open Browser    https://www.lucknowsupergiants.in/   Chrome
            Maximize Browser Window
            Verify Navigation To Play Store    //a[@title="IOS"]   https://apps.apple.com/us/app/lucknow-super-giants/id6446286246

share news icon
#     Open Browser    https://www.lucknowsupergiants.in/news/marcus-stoinis-world-no-1-icc-men-t20i-all-rounder-rankings   Chrome
   Open Browser  https://stg-rr.sportz.io/latest-news       chrome
    Maximize Browser Window
#    Share icon on news and photos    //button[@class="social-icon icon-facebook"]
    Share icon on news and photos    (//button[@class="social-icon icon-whatsapp"])[1]      //div[contains(@class,'social-share')]