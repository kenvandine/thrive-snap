*** Settings ***
Documentation    Test cases for thrive snap
Resource         kvm.resource


*** Test Cases ***
Thrive Launches And Renders
    [Documentation]    Verify thrive snap launches and renders a UI on Mir
    [Tags]    smoke    yarf:certification_status: blocker
    Log Screenshot
