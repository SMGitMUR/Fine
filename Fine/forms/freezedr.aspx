<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="freezedr.aspx.cs" Inherits="Fine.forms.freezedr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title" style="color: black">Freeze Driver User</h2>
                </div>
                <div class="card-body">
                    <div class="form">

                       

                        <asp:Panel ID="freeze" Visible="true" CssClass="form-row" runat="server">
                            <asp:Label ID="Label2" runat="server" Text="Driver Id:" AssociatedControlID="txtjsId"></asp:Label>
                            <br />
                            <asp:TextBox ID="txtjsId" runat="server" CssClass="input--style-6" Enabled="false" />
                            <br />

                            <asp:Label ID="Label5" runat="server" Text="Driver Firstname:" AssociatedControlID="txtfname"></asp:Label>
                            <br />
                            <asp:TextBox ID="txtfname" runat="server" CssClass="input--style-6" Enabled="false" />
                            <br />


                            <asp:Label ID="Label6" runat="server" Text="Driver Lastname:" AssociatedControlID="txtlname"></asp:Label>
                            <br />
                            <asp:TextBox ID="txtlname" runat="server" CssClass="input--style-6" Enabled="false" />
                            <br />



                            <asp:Label ID="Label3" runat="server" Text="Driver NIC:" AssociatedControlID="txtNIC"></asp:Label>
                            <br />
                            <asp:TextBox ID="txtNIC" runat="server" CssClass="input--style-6" Enabled="false" />
                            <br />


                            <asp:Label ID="Label4" runat="server" Text="Driver LIC:" AssociatedControlID="txtlic"></asp:Label>
                            <br />
                            <asp:TextBox ID="txtlic" runat="server" CssClass="input--style-6" Enabled="false" />
                            <br />


                            <asp:Label ID="Label1" runat="server" Text="Status:" AssociatedControlID="txtstatus"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="rfv1" ErrorMessage="*Required!" ControlToValidate="txtstatus" ValidationGroup="vgAdd"></asp:RequiredFieldValidator>

                            <br />
                            <asp:TextBox ID="txtstatus" runat="server" CssClass="input--style-6" autocomplete="off"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtstatus" ValidationExpression="^[a-zA-Z\s]+$" runat="server" ErrorMessage="Only Letters"></asp:RegularExpressionValidator>
                            
                            <br />

                            <br />

                            <h2><asp:Label ID="lblMsg" runat="server" Text="" CssClass="textsuccess"></asp:Label></h2>
                        </asp:Panel>

                         <div class="card-footer">
                            <asp:Button ID="btnBlock" runat="server" CssClass="btn btn--radius-2 btn--blue-2" Text="Block/Unblocked" ValidationGroup="vgAdd" OnClick="btnBlock_Click" />

                        </div>

                        <div class="card-footer">
                            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn--radius-2 btn--blue-2" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />
                        </div>


                        <asp:Panel ID="table" Visible="true" CssClass="form-row" runat="server">
                            <div class="table-responsive table-striped table-hover" style="width: 100%">
                                <asp:GridView ID="gvCatNames" DataKeyNames="dr_id" AutoGenerateColumns="false" OnSelectedIndexChanged="gvCatNames_SelectedIndexChanged" runat="server">
                                    <HeaderStyle BackColor="#9a9a9a" ForeColor="Black" Height="30" />
                                    <AlternatingRowStyle BackColor="#f5f5f5" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnSelect" runat="server" CssClass="btn btn-block" CommandName="Select" Text="Select" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="First Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName" Text='<%#Eval("dr_fname")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName2" Text='<%#Eval("dr_lname")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UserName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName3" Text='<%#Eval("dr_uname")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="NIC">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName5" Text='<%#Eval("dr_nic")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="License Number">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName6" Text='<%#Eval("dr_lic")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCatName4" Text='<%#Eval("dr_status")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </asp:Panel>

                    </div>

                </div>
            </div>

        </div>
    </div>
</asp:Content>
