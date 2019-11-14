page 80100 "AIR Environments Setup"
{

    PageType = Card;
    SourceTable = "AIR Environments Setup";
    UsageCategory = Administration;
    ApplicationArea = Basic;
    Caption = 'Environments Setup';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Base API url"; "Resource url")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;

                }
                field("Tenant Domain"; "Tenant Domain")
                {
                    ApplicationArea = All;
                }
                field("App Id"; "App Id")
                {
                    ApplicationArea = All;
                }
                field("User Name"; "User Name")
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    Caption = 'User Password';
                    ToolTip = 'Specifies the user password';
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        SavePassword(Password);
                        COMMIT;
                        IF Password <> '' THEN
                            CheckEncryption;
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("LGS TestConnection")
            {
                Caption = 'Test Connection';
                ToolTip = 'Test Connection with the subsidiary web service';
                Image = LinkWeb;
                ApplicationArea = Basic;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ConnectionIsSuccessfullyEstablishedMsg: Label 'Congratulations! Connection is successfully established.';
                    ErrorMsg: Text;
                begin
                    if not isConnectionEstablished(true, ErrorMsg) then
                        Error(ErrorMsg);
                    Message(ConnectionIsSuccessfullyEstablishedMsg);
                end;

            }
        }
    }

    var
        Password: Text[50];
        CheckedEncryption: Boolean;
        EncryptionIsNotActivatedQst: Label 'Data encryption is not activated. It is recommended that you encrypt data. \Do you want to open the Data Encryption Management window?';


    trigger OnOpenPage()
    begin
        InsertIfNotExists();
    end;

    trigger OnAfterGetRecord()
    begin

        IF HasPassword() THEN
            Password := 'Password Dots';
    end;


    procedure CheckEncryption()
    begin
        IF NOT CheckedEncryption AND NOT ENCRYPTIONENABLED THEN BEGIN
            CheckedEncryption := TRUE;
            IF CONFIRM(EncryptionIsNotActivatedQst) THEN BEGIN
                PAGE.RUN(PAGE::"Data Encryption Management");
                CheckedEncryption := FALSE;
            END;
        END;
    end;




}
