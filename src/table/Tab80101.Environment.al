table 80101 "AIR Environment"
{

    fields
    {
        field(1; id; Integer)
        {
            AutoIncrement = true;
        }

        field(2; Name; Text[50])
        {

        }
        field(3; Country; Text[2])
        {

        }
        field(4; Version; Text[50])
        {

        }
        field(5; Status; Text[50])
        {
        }
        field(6; Type; Text[50])
        {
        }
        field(10; webClientLoginUrl; text[250])
        {

        }

    }

    keys
    {
        key(PK; "id")
        {
            Clustered = true;
        }
    }

    procedure GetBCCloudEnvironments();
    var
        EnvironmentMgt: Codeunit "AIR Environments Mgt.";
    begin
        EnvironmentMgt.GetBCCloudEnvironments();
    end;

    procedure RunCreateNewEnvironmentWizard();
    var
        EnvironmentMgt: Codeunit "AIR Environments Mgt.";
    begin
        EnvironmentMgt.RunCreateNewEnvironmentWizard();
    end;

    procedure NewBCCloudEnvironment(EnvironmentName: text[30]; EnvironmentCountry: code[2]; EnvironmentVersion: code[20]; EnvironmentType: Text);
    var
        EnvironmentMgt: Codeunit "AIR Environments Mgt.";
    begin
        EnvironmentMgt.NewBCCloudEnvironment(EnvironmentName, EnvironmentCountry, EnvironmentVersion, EnvironmentType);
    end;

    procedure RemoveBCCloudEnvironment()
    var
        EnvironmentMgt: Codeunit "AIR Environments Mgt.";
    begin
        EnvironmentMgt.RemoveBCCloudEnvironment(Name);
    end;


}