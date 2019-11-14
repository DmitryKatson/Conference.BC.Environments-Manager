codeunit 80102 "AIR Install Codeunit"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Record "AIR Environments Setup";
    begin
        Setup.InsertIfNotExists();
        Setup."App Id" := '581e2ea2-008e-44e9-8ec0-9e5d40540b27';
        Setup."Resource url" := 'https://api.businesscentral.dynamics.com';
        Setup."Tenant Domain" := 'airappsbctestus.onmicrosoft.com';
        Setup."User Name" := 'admin.prem@airappsbctestus.onmicrosoft.com';
        Setup.SavePassword('Dmitry$$$2019');
        Setup.Modify();
    end;

}