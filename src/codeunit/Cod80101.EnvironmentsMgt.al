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

    procedure GetAuthHeader(URL: Text; Username: Text; Password: Text; TenantDomain: Text; AppId: Guid) Token: Text
    var
        HttpClient: HttpClient;
        ContentHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        Content: HttpContent;
        Response: HttpResponseMessage;
        authUrl: Label 'https://login.microsoftonline.com/%1/oauth2/token';
        body: Text;
        ResponseText: Text;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        body := StrSubstNo('grant_type=password&username=%1&password=%2&client_id=%3&resource=%4',
                                                Username,
                                                Password,
                                                AppId,
                                                URL);
        Content.WriteFrom(body);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        HttpClient.Post(StrSubstNo(authUrl, TenantDomain), Content, Response);


        Response.Content.ReadAs(ResponseText);
        JsonObject.ReadFrom(ResponseText);
        JsonObject.SelectToken('access_token', JsonToken);

        Token := JsonToken.AsValue().AsText();
    end;

    procedure GetBCCloudEnvironments();
    var
        GetBCCloudEnvironments: Codeunit "AIR GetBCCloudEnvironments WS";
    begin
        GetBCCloudEnvironments.GetBCCloudEnvironments();
    end;
}