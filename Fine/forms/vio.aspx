<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="vio.aspx.cs" Inherits="Fine.forms.vio" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=70);
            opacity: 0.7;
        }

        .modalPopup {
            background-color: #445858;
            border-width: 3px;
            border-style: solid;
            border-color: Gray;
            padding: 3px;
            width: 500px;
        }

            .modalPopup p {
                padding: 5px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="padding: 20px 0">
        <div class="table-title">
            <div class="row">
                <div class="col-sm-8">
                    <h2>Traffic <b>Offences</b></h2>
                </div>
                <div class="col-sm-4">
                    <asp:LinkButton ID="lnkbtnadd" class="btn btn-info add-new" OnClick="lnkbtnadd_Click" runat="server"><i class="fa fa-plus"></i> Add New</asp:LinkButton>

                </div>
            </div>
        </div>
        <asp:Label ID="lblstatus" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
        <div class="container">
            <asp:DataList ID="dlcat" CssClass="table table-hover table-responsive" runat="server">
                <HeaderTemplate>
                    <th>Violation Name</th>
                    <th>Price(Rs)</th>
                    <th>Point</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </HeaderTemplate>
                <ItemTemplate>
                    <td>
                        <asp:Label ID="lblcatname" runat="server" Text='<%#Eval("cat_name")%>'></asp:Label></td>
                    <asp:Label ID="lblcatid" runat="server" Visible="false" Text='<%#Eval("cat_id")%>'></asp:Label>
                    <td>
                        <asp:Label ID="lblCatPrice" runat="server" Text='<%#Eval("cat_price")%>'></asp:Label></td>
                    <td>
                        <asp:Label ID="lblCatPoint" runat="server" Text='<%#Eval("cat_point")%>'></asp:Label></td>
                    <td>
                        <asp:LinkButton ID="lnkbtnedit" OnClick="lnkbtnedit_Click" class="update btn btn-warning btn-sm" runat="server"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>
                    <td>
                        <asp:LinkButton ID="lnkbtndelete" OnClick="lnkbtndelete_Click" class="delete btn btn-danger btn-sm" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                </ItemTemplate>
            </asp:DataList>
        </div>

    </div>

    <asp:Panel ID="pnledit" runat="server">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Update Violation</h4>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblcatnamess" runat="server" Text="Category Name:"></asp:Label>
                    <asp:TextBox ID="txtcatname" class="form-control" runat="server"></asp:TextBox>
                   

                    <asp:Label ID="UpPrice" runat="server" Text="Price(Rs):"></asp:Label>
                    <asp:TextBox ID="txtupprice" TextMode="Number" min="0" class="form-control" runat="server"></asp:TextBox>
                    

                    <asp:Label ID="Label1" runat="server" Text="Point:"></asp:Label>
                    <asp:TextBox ID="txtuppoint" TextMode="Number"  min="0" class="form-control" runat="server"></asp:TextBox>
                   
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnupdate" OnClick="btnupdate_Click" class="btn btn-warning" runat="server" Text="Update" />
                    <asp:Button ID="btnclose" class="btn btn-default" runat="server" Text="Close" />
                </div>
            </div>
        </div>
    </asp:Panel>


    <asp:Button runat="server" ID="hiddenTargetControlForModalPopup" Style="display: none" />
    <asp:Button runat="server" ID="hiddenTargetControlForModalPopup3" Style="display: none" />
    <asp:Button runat="server" ID="hiddenTargetControlForModalPopup2" Style="display: none" />
    <ajaxToolkit:ModalPopupExtender runat="server" ID="pmpedit" BehaviorID="programmaticModalPopupBehavior"
        TargetControlID="hiddenTargetControlForModalPopup2" PopupControlID="pnledit"
        BackgroundCssClass="modalBackground" DropShadow="True"
        RepositionMode="RepositionOnWindowScroll">
    </ajaxToolkit:ModalPopupExtender>

    <asp:Panel ID="pnldelete" runat="server">

        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Delete Violation</h4>
            </div>
            <div class="modal-body">
                <strong>Are you sure you want to delete this data?</strong>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btndelete" OnClick="btndelete_Click" class="btn btn-danger" runat="server" Text="Delete" />
                <asp:Button ID="btnclose2" class="btn btn-default" runat="server" Text="Close" />
            </div>
        </div>

    </asp:Panel>
    <ajaxToolkit:ModalPopupExtender runat="server" ID="pmpdelete" BehaviorID="programmaticModalPopupBehavior2"
        TargetControlID="hiddenTargetControlForModalPopup" PopupControlID="pnldelete"
        BackgroundCssClass="modalBackground" DropShadow="True"
        RepositionMode="RepositionOnWindowScroll">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Panel ID="pnlinsert" runat="server">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Insert Violation</h4>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblcatinsert" runat="server" Text="Category Name:"></asp:Label>
                    <asp:TextBox ID="txtinsert" class="form-control" runat="server"></asp:TextBox>
                   

                    <asp:Label ID="Price" runat="server" Text="Price(Rs):"></asp:Label>
                    <asp:TextBox ID="txtprice" TextMode="Number" min="0" class="form-control" runat="server"></asp:TextBox>
                    
                     <asp:Label ID="Label2" runat="server" Text="Point:"></asp:Label>
                    <asp:TextBox ID="txtpoint" TextMode="Number" min="0" class="form-control" runat="server"></asp:TextBox>
                    
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btninsert" OnClick="btninsert_Click" class="btn btn-warning" runat="server" Text="Insert" />
                    <asp:Button ID="btnclose3" class="btn btn-default" runat="server" Text="Close" />
                </div>
            </div>
        </div>
    </asp:Panel>
    <ajaxToolkit:ModalPopupExtender runat="server" ID="pmpinsert" BehaviorID="programmaticModalPopupBehavior3"
        TargetControlID="hiddenTargetControlForModalPopup3" PopupControlID="pnlinsert"
        BackgroundCssClass="modalBackground" DropShadow="True"
        RepositionMode="RepositionOnWindowScroll">
    </ajaxToolkit:ModalPopupExtender>
</asp:Content>

