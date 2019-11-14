table 80100 "AIR Environments Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }
        field(10; "Base API url"; text[250])
        {
            ExtendedDatatype = URL;
            trigger OnValidate()
            begin
                CheckIfValidUrl("Base API url");
            end;
        }
        field(11; "Tenant Domain"; Text[250])
        {

        }
        field(12; "App Id"; Guid)
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

}