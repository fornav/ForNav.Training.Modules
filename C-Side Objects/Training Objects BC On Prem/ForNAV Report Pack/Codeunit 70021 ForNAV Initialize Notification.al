Codeunit 70021 "ForNAV Initialize Notification"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    [EventSubscriber(Objecttype::Page, 1518, 'OnInitializingNotificationWithDefaultState', '', true, true)]
    local procedure OnInitializingNotificationWithDefaultState()
    var
        MyNotifications: Record "My Notifications";
        SetupForNAVTxt: label 'Ask to setup ForNAV.';
        SetupForNAVDescriptionTxt: label 'If you have ForNAV installed but don''t want to use it, switch off receiving the notification.';
        NotificationIDs: Codeunit "ForNAV Notification IDs";
    begin
        MyNotifications.InsertDefaultWithTableNum(NotificationIDs.SetupForNAV,
          SetupForNAVTxt,
          SetupForNAVDescriptionTxt,
          Database::"ForNAV Setup");
    end;
}

