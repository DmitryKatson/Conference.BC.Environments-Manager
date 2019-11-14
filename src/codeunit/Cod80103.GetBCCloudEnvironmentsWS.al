codeunit 80103 "AIR GetBCCloudEnvironments WS"
{
    procedure GetBCCloudEnvironments()
    var
        Arguments: Record "AIR WebService Argument";
        APIRequest: Text;
        Environment: Record "AIR Environment";
    begin
        APIRequest := '/v1.2/admin/applications/BusinessCentral/environments/';

        InitArguments(Arguments, APIRequest);

        IF not CallWebService(Arguments) then
            EXIT;

        SaveResultInEnvironmentsTable(Arguments, Environment);
    end;

    local procedure InitArguments(var Arguments: Record "AIR WebService Argument" temporary; APIRequest: Text);
    var
        ConnectionSetup: Record "AIR Environments Setup";
    begin
        WITH Arguments DO begin
            URL := STRSUBSTNO('%1%2', ConnectionSetup.GetBaseURL(), APIRequest);
            RestMethod := RestMethod::get;
            Bearer := ConnectionSetup.GetAuthToken();
        end;
    end;

    local procedure CallWebService(var Arguments: Record "AIR WebService Argument" temporary) Success: Boolean
    var
        WebService: codeunit "AIR WebService Call Functions";
    begin
        Success := WebService.CallWebService(Arguments);
    end;

    local procedure SaveResultInEnvironmentsTable(var Arguments: Record "AIR WebService Argument" temporary; var Environment: Record "AIR Environment")
    var
        WebService: Codeunit "AIR WebService Call Functions";
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        i: Integer;
        ResponseInTextFormat: Text;
    begin
        ResponseInTextFormat := Arguments.GetResponseContentAsText;
        HandleResponseForJsonArrayFormat(ResponseInTextFormat);
        Environment.DeleteAll;
        If not JsonArray.ReadFrom(ResponseInTextFormat) then
            error('Invalid response, expected an JSON array as root object');
        For i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            JsonObject := JsonToken.AsObject;
            WITH Environment do begin
                Init();
                id := i + 1;
                Type := WebService.SelectJsonValueAsText(JsonObject, 'type');
                Name := WebService.SelectJsonValueAsText(JsonObject, 'name');
                Country := WebService.SelectJsonValueAsText(JsonObject, 'countryCode');
                Version := WebService.SelectJsonValueAsText(JsonObject, 'applicationVersion');
                Status := WebService.SelectJsonValueAsText(JsonObject, 'status');
                webClientLoginUrl := WebService.SelectJsonValueAsText(JsonObject, 'webClientLoginUrl');
                Insert(true);
            end;
        end;
    end;

    local procedure HandleResponseForJsonArrayFormat(var Response: Text);
    var
        Jobj: JsonObject;
        Jtoken: JsonToken;
        WebService: Codeunit "AIR WebService Call Functions";
    begin
        Jobj.ReadFrom(Response);
        Jtoken := WebService.SelectJsonToken(Jobj, 'value');
        Jtoken.WriteTo(Response);
    end;

}