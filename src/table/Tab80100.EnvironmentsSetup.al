table 80100 "AIR Environments Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }
        field(10; "Resource url"; text[250])
        {
            ExtendedDatatype = URL;
            trigger OnValidate()
            begin
                CheckIfValidUrl("Resource url");
            end;
        }
        field(11; "Tenant Domain"; Text[250])
        {

        }
        field(12; "App Id"; Text[250])
        {

        }
        field(13; "User Name"; Text[250])
        {
            Caption = 'User Name';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(14; "Password Key"; Guid)
        {
            TableRelation = "Service Password".Key;
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure InsertIfNotExists()
    var
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    local procedure CheckIfValidUrl(url: Text)
    var
        WebRequestHelper: Codeunit "Web Request Helper";
    begin
        if url = '' then
            exit;
        WebRequestHelper.IsValidUri(url);
    End;

    procedure SavePassword(PasswordText: Text)
    var
        ServicePwdMgt: Codeunit "AIR Isolated Storage Mgt.";
    begin
        ServicePwdMgt.SavePassword(PasswordText, "Password Key");
    end;

    procedure HasPassword(): Boolean
    var
        ServicePwdMgt: Codeunit "AIR Isolated Storage Mgt.";
    begin
        exit(ServicePwdMgt.HasPassword("User Name", "Password Key"));
    end;

    procedure GetPassword(): Text
    var
        ServicePwdMgt: Codeunit "AIR Isolated Storage Mgt.";
    begin
        exit(ServicePwdMgt.GetPassword("User Name", "Password Key"));
    end;

    local procedure DeletePassword()
    var
        ServicePwdMgt: Codeunit "AIR Isolated Storage Mgt.";
    begin
        ServicePwdMgt.DeletePassword("Password Key");
    end;

    procedure isConnectionEstablished(ShowErrorMsg: Boolean; var ErrorMsg: Text): Boolean
    var
        EnvironmentsMgt: Codeunit "AIR Environments Mgt.";
    begin
        Exit(EnvironmentsMgt.CheckConnection("Resource url", "User Name", GetPassword(), "Tenant Domain", "App Id", ShowErrorMsg, ErrorMsg));
    end;

    procedure GetBaseURL(): Text
    begin
        InsertIfNotExists();
        exit("Resource url");
    end;

    procedure GetUserName(): Text
    begin
        InsertIfNotExists();
        exit("User Name");
    end;

    procedure GetAuthToken(): Text
    var
        EnvironmentMgt: Codeunit "AIR Environments Mgt.";
    begin
        InsertIfNotExists();
        exit(EnvironmentMgt.GetAuthHeader("Resource url", "User Name", GetPassword(), "Tenant Domain", "App Id"));
    end;



}