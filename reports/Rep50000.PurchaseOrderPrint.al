report 50000 "Purchase Order Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'reports\PurchaseOrderPrint.rdl';

    dataset
    {
        dataitem(TransferHeader; "Transfer Header")
        {
            column(No; "No.") { }
            column(Document_Date; "Document Date") { }
            column(TransferfromCode; "Transfer-from Code") { }
            column(Transfer_from_Name; "Transfer-from Name") { }
            column(Transfer_from_Address; "Transfer-from Address") { }
            column(TransfertoCode; "Transfer-to Code") { }
            column(Transfer_to_Address; "Transfer-to Address") { }
            column(Transfer_to_Name; "Transfer-to Name") { }
            column(FGSupplierNo; "FG Supplier No.") { }
            column(FGSupplierName; "FG Supplier Name") { }
            column(DSM_Code; "DSM Code") { }
            column(DSM_Name; "DSM Name") { }
            column(Process_No_; "Process No.") { }
            column(Process_rec_ProcessName; Process_rec."Process Name") { }
            column(Transport_Method; "Transport Method") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Transaction_Type; "Transaction Type") { }
            column(Promised_Receipt_Date; "Promised Receipt Date") { }
            column(Total_Amount; "Total Amount") { }
            column(Total_Quantity; "Total Quantity") { }


            dataitem(TransferLine; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = sorting("Document No.") where("Derived From Line No." = const(0));

                DataItemLinkReference = TransferHeader;
                column(Item_No_; "Item No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(Unit_Cost; "Unit Cost") { }
                column(Line_Amount; "Line Amount") { }
            }

            trigger OnAfterGetRecord()
            begin
                if "Process No." <> '' then
                    Process_rec.Get("Process No.");
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        Process_rec: Record Process;
}
