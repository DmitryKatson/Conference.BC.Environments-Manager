codeunit 80102 "AIR Install Codeunit"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Record "AIR Environments Setup";
    begin
        Setup.InsertIfNotExists();
        Setup."App Id" := 'someid';
        Setup."Resource url" := 'https://api.businesscentral.dynamics.com';
        Setup."Tenant Domain" := 'sometetant.onmicrosoft.com';
        Setup."User Name" := 'user@sometetant.onmicrosoft.com';
        Setup.SavePassword('somepassword');
        Setup.Modify();
    end;

}