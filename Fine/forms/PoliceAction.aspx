<%@ Page Title="" Language="C#" MasterPageFile="~/police.Master" AutoEventWireup="true" CodeBehind="PoliceAction.aspx.cs" Inherits="Fine.forms.PoliceAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Violation Action</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>
    <style>
        .floater {
            float: left;
            border: solid 1px black;
            padding: 5px;
            margin: 5px;
        }
    </style>

    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">

                <div class="card-body">
                    <div class="form">
                        <div class="card-heading">
                            <h2 class="title" style="color: black">Violation Action</h2>
                        </div>
                        <div class="form-row">
                         <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                       </div>

                        <asp:Repeater ID="repUser" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Panel runat="server" Visible='<%# Container.ItemIndex == 0 %>'>
                                    <h3><b>Fullname:</b> <%# Eval("fullname") %></h3>
                                    <br />
                                    <h3><b>License Number :</b> <%# Eval("dr_lic") %></h3>
                                    <br />
                                    <h3><b>NIC :</b> <%# Eval("dr_nic") %></h3>
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price(Rs)</th>
                                            <th scope="col">Point</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                </asp:Panel>
                                <tr>
                                    <td><%# Container.ItemIndex %></td>
                                    <td><%# Eval("cat_name") %></td>
                                    <td><%# Eval("cat_price") %></td>
                                    <td><%# Eval("cat_point") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div class="form-row">
                            <div class="name">Action</div>
                            <div class="value">
                                <asp:DropDownList ID="ddlAction" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAction_SelectedIndexChanged" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:ListItem Selected="True" Value="Pay"> Pay Only Fine </asp:ListItem>
                                    <asp:ListItem Value="Court"> Court And Pay Fine</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <asp:Panel ID="pnlCourtDate" Visible="false" CssClass="form-row" runat="server">
                            <div class="name">Court Date</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtDate" runat="server" Type="Date" placeholder="Court Date" class="input--style-6" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    <asp:Label ID="lbldate" runat="server"></asp:Label>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="form-row">
                            <div class="name">Comments</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox cols="20" Rows="2" ID="txtCom" runat="server" class="name input--style-6" placeholder=".."></asp:TextBox>

                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txtCom" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Register" OnClick="btnRegister_Click" />
                        </div>


                       
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
