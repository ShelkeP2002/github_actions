*** Settings ***
Library     SeleniumLibrary
Library    Collections
Library    String
Library    ../../Utilities/user_keywords.py
Library    ../../../Utilities/user_keywords.py

*** Variables ***
${Mobile_num}   9800000001
#${filepath}     ${CURDIR}${/}web_common.xlsx
${MOBILE_NUM_FILE}       ${CURDIR}${/}..${/}TestData${/}mobile_num.xlsx
${expected_player_file}     ${CURDIR}${/}..${/}TestData${/}player_details.xlsx
${table_header_list}     ${CURDIR}${/}..${/}TestData${/}table_header.xlsx
${player_profile_verification}     ${CURDIR}${/}..${/}TestData${/}player_verification.xlsx
${table_column_details_list}     ${CURDIR}${/}..${/}TestData${/}details.xlsx
@{expected player}      SANJU SAMSON  DHRUV JUREL   JOS BUTTLER   KUNAL SINGH RATHORE  TOM KOHLER-CADMORE   fds  fds  dfs  dsf  sdgf  sdsdv    dsgs  sdg  sdf  sdsd  dsg dffs   dsf   dsf   dsf   dsdf   dfds   sdf sdg sdgd sdg sddg sdf sdg sdg sdg sdg
*** Keywords ***
Login With Otp For Web
    [Arguments]     ${Login}   ${Mobile_input}    ${excel_data}
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${Login}   timeout=20s
#    Click Element    ${Login}
    Wait Until Element Is Visible    ${Mobile_input}    timeout=30s
    Input Text    ${Mobile_input}   ${my_dict['mobile_num']}


squad Verification
    [Arguments]     ${player_card}     ${player_name}    ${Player_role}   ${excel_data}
    ${my_dict}=  Create Dictionary      &{excel_data}
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
#        Log    @{split}
        ${fullname}=   Evaluate    "${split}[0] ${split}[1]"
        Log    ${fullname}
       Append To List   ${Actual_list}   ${fullname}
       Log    ${Actual_list}
    END
       ${expected_player}  Get From Dictionary    ${my_dict}    players
       Lists Should Be Equal      ${expected_player}    ${Actual_list}

Player Profile Verification
    [Arguments]     ${squad_page_verification}   ${player_card_xpath}    ${player_name_xpath}  ${excel_data}  ${date_of_birth}=None    ${batting_style}=None    ${bowling_style}=None  ${view_profile}=None
    [Documentation]     Pass xpath of respective divisions without using its inner text
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${squad_page_verification}       timeout=20s
    Mouse Over    ${player_card_xpath}
     ${view_profile_present}=    Run Keyword And Return Status    Element Should Be Visible    ${view_profile}
      IF   '${view_profile_present}' == 'True'
           Click Element    ${view_profile}
      ELSE
            Click Element    ${player_card_xpath}
      END
      Sleep    2s
    ${date_of_birth_visible}=  Run Keyword And Return Status     Element Should Be Visible    ${date_of_birth}
    IF    '${date_of_birth_visible}'=='True'
         Wait Until Element Is Visible    ${date_of_birth}     timeout=30s
         Element Should Be Visible    ${date_of_birth}
         ${date_of_birth_value}  Get Text    ${date_of_birth}
         Should Be Equal As Strings    ${date_of_birth_value}    ${my_dict['dob']}
         Element Should Be Visible    ${batting_style}
         ${batting_style_value}  Get Text    ${batting_style}
         Should Be Equal As Strings    ${batting_style_value}    ${my_dict['batting_style']}
         Element Should Be Visible    ${bowling_style}
         ${bowling_style_value}  Get Text    ${bowling_style}
         Should Be Equal As Strings    ${bowling_style_value}    ${my_dict['bowling_style']}
         Element Should Be Visible    ${player_name_xpath}
         ${player_name_value}  Get Text    ${player_name_xpath}
         Should Be Equal As Strings    ${player_name_value}    ${my_dict['player_name']}


    END


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
   ${my_dict}=  Create Dictionary      &{header_text_list}
   @{column_list}    Create List
    @{table_header}   Get Webelements    ${table_header_text_xpath}
   FOR   ${column_name}    IN    @{table_header}
       ${column_name}     Get Text    ${column_name}
       Append To List    ${column_list}    ${column_name}
       Log     ${column_list}
   END
     ${expected_table_header}  Get From Dictionary    ${my_dict}    HEADER
   Lists Should Be Equal    ${column_list}    ${expected_table_header}


Verify Table Column Details
   [Arguments]    ${column_content_list}    ${column_text_xpath}
   [Documentation]    Takes list of all column values and common xpath of column text elements
   ${my_dict}=  Create Dictionary      &{column_content_list}
   @{column_value_list}    Create List
    Sleep    2
   @{column_values}   Get Webelements    ${column_text_xpath}
   FOR   ${column_value}    IN    @{column_values}
       ${column_value_text}     Get Text    ${column_value}
       Append To List    ${column_value_list}    ${column_value_text}
   END
     ${expected_column_details}  Get From Dictionary    ${my_dict}    Details
   Lists Should Be Equal    ${column_value_list}    ${expected_column_details}


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
   ${cell_value_text}    Get Text    ${xpath_of_table_shell}
   Should Be Equal    ${cell_value_text}    ${cell_value}

Sign Up Details Web
    [Arguments]   ${firstname}  ${lastname}   ${excel_data}   ${mail}=None     ${mobile_num}=None
    ${my_dict}=  Create Dictionary      &{excel_data}
    Wait Until Element Is Visible    ${firstname}   timeout=30s
    Input Text    ${firstname}    ${my_dict.firstname}
    Wait Until Element Is Visible    ${lastname}    timeout=30s
    Input Text    ${lastname}    ${my_dict.lastname}
    ${mail_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mail}
    ${mobile_num_present}=  Run Keyword And Return Status    Element Should Be Visible    ${mobile_num}
    Run Keyword If    '${mail_present}'== 'True'  Input Text    ${mail}    abc@gmail.com
    Run Keyword If    '${mobile_num_present}'== 'True'  Input Text    ${mobile_num}    9999999999

Player Profile Verification for pk
    [Arguments]     ${squad_page_verification}   ${specific_player_card_xpath}      ${specific_player_name_xpath}  ${excel_data}  ${date_of_birth}=None    ${batting_style}=None    ${bowling_style}=None  ${view_profile}=None
    [Documentation]     Pass xpath of respective divisions without using its inner text
    Log    ${excel_data}
    Wait Until Element Is Visible    ${squad_page_verification}       timeout=20s
    Scroll Element Into View    ${specific_player_name_xpath}
    Mouse Over    ${specific_player_name_xpath}
     ${view_profile_present}=    Run Keyword And Return Status    Element Should Be Visible    ${view_profile}
      IF   '${view_profile_present}' == 'True'
           Scroll Element Into View    ${view_profile}
           Click Element    ${view_profile}
      ELSE
            Click Element    ${specific_player_card_xpath}
      END
      Sleep    2s
    ${date_of_birth_visible}=  Run Keyword And Return Status     Element Should Be Visible    ${date_of_birth}
    IF    '${date_of_birth_visible}'=='True'
         Wait Until Element Is Visible    ${date_of_birth}     timeout=30s
         Element Should Be Visible    ${date_of_birth}
         ${date_of_birth_value}  Get Text    ${date_of_birth}
         ${fulldate}=   Evaluate    "${excel_data['dob']}[0], ${excel_data['dob']}[1]"
         Should Be Equal   ${date_of_birth_value}   ${fulldate}

         Element Should Be Visible    ${batting_style}
         ${batting_style_value}  Get Text    ${batting_style}
         Should Be Equal As Strings    ${batting_style_value}    ${excel_data['batting_style']}

         Element Should Be Visible    ${bowling_style}
         ${bowling_style_value}  Get Text    ${bowling_style}
         Should Be Equal As Strings    ${bowling_style_value}    ${excel_data['bowling_style']}

         Element Should Be Visible    ${specific_player_name_xpath}
         ${player_name_value}  Get Text    ${specific_player_name_xpath}
         @{split}=   Split String    ${player_name_value}      \n
         ${fullname}=   Evaluate    "${split}[0] ${split}[1]"
         Should Be Equal As Strings    ${fullname}    ${excel_data['player_name']}
    END



*** Test Cases ***
Player profile verification test case
    ${excel_data}=   Fetch Data By Id    ${player_profile_verification}    1
#    Open Browser    https://www.punjabkingsipl.in/players    Chrome
    Open Browser   https://www.lucknowsupergiants.in/team   chrome
    Maximize Browser Window
    Sleep    2s
    Click Element    //button[text()='I accept']
    Sleep    5s
#    player profile verification    //a[normalize-space()="View Profile"]    //span[text()='Players']   //div[@class="player-wrap"]     //p[text()='born']//following-sibling::p[@class="player-meta-value"]    //span[@class="name first-name"]    //p[text()='Batting Style']//following-sibling::p[@class="player-meta-value"]    //p[text()='Bowling Style']//following-sibling::p[@class="player-meta-value"]
#    Player Profile Verification for pk   //h1[normalize-space()='Sadda Squad']     //div[@class="squad-wrapper"]    //div[@class="squad-name"]    ${excel_data}   //p[text()='Born']//following-sibling::p[@class="value"]    //p[text()='Batting Style']//following-sibling::p[@class="value"]   //p[text()='Bowling Style']//following-sibling::p[@class="value"]
    Player Profile Verification for pk    //h1[normalize-space()='Squad']    //p[text()='Ayush']//parent::div//parent::div//parent::Div[@class="player-wrap"]    //p[text()='Ayush']//parent::Div    ${excel_data}  //p[text()='Born']//following-sibling::p[@class="value"]   //p[text()='Batting Style']//following-sibling::p[@class="value"]   //p[text()='Bowling Style']//following-sibling::p[@class="value"]  //p[text()='Ayush']//parent::Div//following-sibling::Div//child::div//child::a
sign UP
    &{excel_data}   Fetch Data By Id    ${filepath}    1
    Open Browser    https://www.mumbaiindians.com/login   chrome
    Sign Up Details Web    //input[@id="fname"]    //input[@id="lname"]   ${excel_data}

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

squad verification
    ${excel_data}=   Fetch Data By Id    ${expected_player_file}    1
    Open Browser     https://stg-rr.sportz.io/rr-players    Chrome
    Squad Verification    //div[@class="player-wrap"]   //div[@class="player-name"]    //p[@class="role"]     ${excel_data}

login test case
    ${excel_data}=   Fetch Data By Id    ${MOBILE_NUM_FILE}    1
    Open Browser    https://stg-rr.sportz.io/login   chrome
    Login With Otp For Web    //h2[text()='Login']    //input[@id="Mobile_number"]     ${excel_data}

table verification header
     ${excel_data}=   Fetch Data By Id    ${table_header_list}    1
    Open Browser   https://stg-rr.sportz.io/ipl-2024-points-table   chrome
    Verify Table Header Details    ${excel_data}   //div[@class="table-head"]//div[contains(@class,'table-data ')]

table column details verification
    ${excel_data}=   Fetch Data By Id    ${table_column_details_list}    1
    Open Browser   https://stg-rr.sportz.io/ipl-2024-points-table   chrome
    Verify Table Column Details    ${excel_data}    //div[@class="table-data matches-won"]//p[@class="count"]
    
    
cell value verification
    Open Browser    https://stg-rr.sportz.io/ipl-2024-points-table    chrome
    Verify Cell Value Verification    //p[text()='+0.273']   +0.273

