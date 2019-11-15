codeunit 80105 "AIR NewBCCloudEnvironments WS"
{
    procedure NewBCCloudEnvironment(EnvironmentName: text[30]; EnvironmentCountry: code[2]; EnvironmentVersion: code[20]; EnvironmentType: Text)
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
        body := GetBodyJson(EnvironmentCountry, EnvironmentVersion, EnvironmentType);

        Content.WriteFrom(body);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        Client.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Bearer %1', ConnectionSetup.GetAuthToken()));

        Client.Put(url, Content, Response);
    end;

    local procedure GetBodyJson(EnvironmentCountry: code[2]; EnvironmentVersion: code[20]; EnvironmentType: Text) Body: Text
    var
        Jobj: JsonObject;
    begin
        Jobj.Add('environmentType', EnvironmentType);
        Jobj.Add('countryCode', EnvironmentCountry);
        Jobj.WriteTo(Body);
    end;
}