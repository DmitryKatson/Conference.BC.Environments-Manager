codeunit 80106 "AIR DelBCCloudEnvironment WS"
{
    procedure RemoveBCCloudEnvironmentConfirm(EnvironmentName: text[30])
    var
        DoYouReallyWantToDeleteEnvironmentQtn: Label 'Do you really want to delete %1 environment?';
        AreYouSureQtn: Label 'Are you sure?';
        AreYouDrunkQtn: Label 'Are you drunk?';
    begin
        if not Confirm(strsubstno(DoYouReallyWantToDeleteEnvironmentQtn, EnvironmentName), false) then
            exit;
        if not Confirm(AreYouSureQtn, false) then
            exit;
        if Confirm(AreYouDrunkQtn, false) then begin
            Message('Sorry, you have to go to sleep');
            exit;
        end;
        Message('Oook, Let''s do it');
        RemoveBCCloudEnvironment(EnvironmentName);

    end;

    procedure RemoveBCCloudEnvironment(EnvironmentName: text[30])
    var
        APIRequest: Text;
        ConnectionSetup: Record "AIR Environments Setup";
        Client: HttpClient;

        Content: HttpContent;
        contentHeaders: HttpHeaders;
        Response: HttpResponseMessage;
        body: Text;
        url: text;
    begin
        APIRequest := StrSubstNo('/admin/v2.0/applications/BusinessCentral/environments/%1', EnvironmentName);
        url := StrSubstNo('%1%2', ConnectionSetup.GetBaseURL(), APIRequest);

        Client.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Bearer %1', ConnectionSetup.GetAuthToken()));

        Client.Delete(url, Response);
    end;
}