codeunit 80101 "AIR Environments Mgt."
{

    procedure CheckConnection(URL: Text; Username: Text; Password: Text; TenantDomain: Text; AppId: Guid; ShowErrorMsg: Boolean; var ErrorMsg: Text): Boolean
    begin
        exit(SendTestRequest(URL, Username, Password, TenantDomain, AppId, ShowErrorMsg, ErrorMsg));
    end;

    local procedure SendTestRequest(URL: Text; Username: Text; Password: Text; TenantDomain: Text; AppId: Guid; ShowErrorMsg: Boolean; var ErrorMsg: Text) isSuccess: Boolean
    begin
        exit(GetAuthHeader(url, Username, Password, TenantDomain, AppId) <> '');
    end;

    procedure GetAuthHeader(URL: Text; Username: Text; Password: Text; TenantDomain: Text; AppId: Guid): Text
    var
        GetAuthHeaderWS: Codeunit "AIR GetAuthHeaderWS";
    begin
        exit(GetAuthHeaderWS.GetToken(URL, Username, Password, TenantDomain, AppId));
    end;

    procedure GetBCCloudEnvironments();
    var
        GetBCCloudEnvironments: Codeunit "AIR GetBCCloudEnvironments WS";
    begin
        GetBCCloudEnvironments.GetBCCloudEnvironments();
    end;

    procedure RunCreateNewEnvironmentWizard()
    begin
        page.RunModal(page::"AIR Env. Creation Wizard");
    end;

    procedure NewBCCloudEnvironment(EnvironmentName: text[30]; EnvironmentCountry: code[2]; EnvironmentVersion: code[20]; EnvironmentType: Text);
    var
        NewBCCloudEnvironment: Codeunit "AIR NewBCCloudEnvironments WS";
    begin
        NewBCCloudEnvironment.NewBCCloudEnvironment(EnvironmentName, EnvironmentCountry, EnvironmentVersion, EnvironmentType);
    end;

    procedure RemoveBCCloudEnvironment(EnvironmentName: text[30]);
    var
        RemoveBCCloudEnvironment: Codeunit "AIR DelBCCloudEnvironment WS";
    begin
        RemoveBCCloudEnvironment.RemoveBCCloudEnvironmentConfirm(EnvironmentName);
    end;



}