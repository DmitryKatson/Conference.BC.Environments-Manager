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
                }
                field(webClientLoginUrl; webClientLoginUrl)
                {
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
        }
    }

}
