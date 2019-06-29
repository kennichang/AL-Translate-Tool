page 78600 "BAC Trans Project List"
{
    Caption = 'Translation Project List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BAC Translation Project Name";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Project Code"; "Project Code")
                {
                    ApplicationArea = All;
                                        AssistEdit=true;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit then
                            CurrPage.Update;
                    end;

                }
                field("Project Name"; "Project Name")
                {
                    ApplicationArea = All;

                }
                field("Source Language"; "Source Language")
                {
                    ApplicationArea = All;
                }
                field("Source Language ISO code"; "Source Language ISO code")
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Source")
            {
                ApplicationArea = All;
                Caption = 'Import Source';
                Image = ImportCodes;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ImportSourceXML: XmlPort "BAC Import Translation Source";
                    TransSource: Record "BAC Translation Source";
                    TransNotes: Record "BAC Translation Notes";
                    DeleteWarningTxt: Label 'This will overwrite the Translation source for %1';
                begin
                    TransSource.SetRange("Project Code", "Project Code");
                    if not TransSource.IsEmpty then
                        if Confirm(DeleteWarningTxt, false, "Project Code") then begin
                            TransSource.DeleteAll();
                            TransNotes.DeleteAll();
                        end else
                            exit;
                    ImportSourceXML.SetProjectCode(Rec."Project Code");
                    ImportSourceXML.Run();
                end;
            }
        }
        area(Navigation)
        {
            action("Translation Source")
            {
                ApplicationArea = All;
                Caption = 'Translation Source';
                Image = SourceDocLine;
                Promoted = true;
                PromotedOnly = true;
                RunObject = page "BAC Translation Source List";
                RunPageLink = "Project Code" = field ("Project Code");
            }
            action("Target Languages")
            {
                ApplicationArea = All;
                Caption = 'Target Languages';
                Image = Language;
                Promoted = true;
                PromotedOnly = true;
                RunObject = page "BAC Target Language List";
                RunPageLink = "Project Code" = field ("Project Code"),
                              "Source Language" = field ("Source Language"),
                              "Source Language ISO code" = field ("Source Language ISO code");
            }
        }
    }
}