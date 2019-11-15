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
}