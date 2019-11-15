codeunit 80104 "AIR GetAuthHeaderWS"
{
    procedure GetToken(URL: Text; Username: Text; Password: Text; TenantDomain: Text; AppId: Guid) Token: Text
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
}