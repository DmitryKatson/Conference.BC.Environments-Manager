page 80101 "AIR Environments"
{

    PageType = List;
    SourceTable = "AIR Environment";
    Caption = 'Environments';
    ApplicationArea = All;
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(webClientLoginUrl);
                    end;
                }
                field(Version; Version)
                {
                    ApplicationArea = All;
                }
                field(Country; Country)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(webClientLoginUrl; webClientLoginUrl)
                {
                    Caption = 'Web client url';
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update")
            {
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    GetBCCloudEnvironments();
                end;
            }
            action(New)
            {
                ApplicationArea = All;
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Create new environment';
                trigger OnAction()
                begin
                    RunCreateNewEnvironmentWizard();
                    GetBCCloudEnvironments();
                end;
            }
            action(Remove)
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Remove environment';
                trigger OnAction()
                begin
                    RemoveBCCloudEnvironment();
                    GetBCCloudEnvironments();
                end;
            }

        }
        area(Navigation)
        {
            action(Setup)
            {
                ApplicationArea = All;
                Image = Setup;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "AIR Environments Setup";
            }
        }
    }
    var
        [InDataSet]
        StyleTxt: Text;

    trigger OnAfterGetRecord()
    begin
        SetStyle(StyleTxt, Status);
    end;

    local procedure SetStyle(var Style: text; Status: Text)
    begin
        style := 'standard';
        If (Status <> 'Active') then
            style := 'Attention';
    end;


}
