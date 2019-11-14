codeunit 80100 "AIR Isolated Storage Mgt."
{
    procedure SavePassword(PasswordText: Text; var PasswordKey: Guid)
    begin
        if PasswordText = '' then
            exit;

        if IsNullGuid(PasswordKey) or not IsolatedStorage.Contains(PasswordKey, DataScope::Company) then
            PasswordKey := CreateGuid();

        if not EncryptionEnabled() then
            IsolatedStorage.Set(PasswordKey, PasswordText, DataScope::Company)
        else
            IsolatedStorage.SetEncrypted(PasswordKey, PasswordText, DataScope::Company);
    end;

    procedure HasPassword(UserName: Text[50]; PasswordKey: Guid): Boolean
    begin
        IF DemoSaaSCompany AND (UserName = '') THEN
            EXIT(true);

        EXIT(IsolatedStorage.Contains(PasswordKey, DataScope::Company));
    end;

    procedure GetPassword(UserName: Text[50]; PasswordKey: Guid) PasswordText: Text
    begin
        IF DemoSaaSCompany AND (UserName = '') THEN
            EXIT('');

        IsolatedStorage.Get(PasswordKey, DataScope::Company, PasswordText);
        exit(PasswordText);
    end;

    procedure DeletePassword(PasswordKey: Guid)
    begin
        IsolatedStorage.Delete(PasswordKey, DataScope::Company);
    end;

    local procedure DemoSaaSCompany(): Boolean
    var
        EnvironmentInfo: Codeunit "Environment Information";
        CompanyInformationMgt: Codeunit "Company Information Mgt.";
    begin
        EXIT(EnvironmentInfo.IsSaaS() AND CompanyInformationMgt.IsDemoCompany);
    end;
}