Codeunit 70020 "ForNAV Notification Actions"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure SetupForNAV(var MyNotification: Notification)
    begin
        Codeunit.Run(Codeunit::"ForNAV First Time Setup");
    end;

    procedure DisableSetup(var MyNotification: Notification)
    var
        MyNotifications: Record "My Notifications";
        NotificationID: Guid;
    begin
        MyNotifications.LockTable;
        NotificationID := MyNotification.ID;
        if MyNotifications.Get(UserId, NotificationID) then begin
          MyNotifications.Enabled := false;
          MyNotifications.Modify;
        end;
    end;
}

