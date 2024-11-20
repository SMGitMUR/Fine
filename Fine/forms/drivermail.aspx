<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="drivermail.aspx.cs" Inherits="Fine.forms.drivermail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Violation Details</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>

    <link href="../Content/leaflet/leaflet.css" rel="stylesheet" />
    <script src="../Content/leaflet/leaflet.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <div class="page-wrapper bg-dark p-t-100 p-b-50">
            <div class="wrapper wrapper--w900">
                <div class="card card-6">

                    <div class="card-body">
                        <div class="form">
                            <div class="card-heading">
                                <h2 class="title" style="color: black">Violation Details</h2>
                            </div>

                             <h3><b>Fullname:</b> <asp:Label ID="lblFname" runat="server" Text=""></asp:Label></h3>
                                    <br />
                                    <h3><b>License Number :</b> <asp:Label ID="lblLic" runat="server" Text=""></asp:Label></h3>
                                      <br />
                                    <h3><b>NIC :</b> <asp:Label ID="lblNic" runat="server" Text=""></asp:Label></h3>
                            <div class="form-row">
                                <div class="name">Violation Date Issued</div>
                                <div class="value">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtDate" runat="server" placeholder="Date" class="input--style-6" ReadOnly="true" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtDate" runat="server" Operator="LessThan" Type="Date" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                            </div>


                            <div class="form-row">
                                <div class="name">Violation Name</div>
                                <div class="value">
                                    <asp:TextBox ID="txtvio" runat="server" class="name input--style-6" placeholder="violation name" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqFname" ControlToValidate="txtvio" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="name">Traffic Offence</div>
                                <div class="value">
                                    <asp:Repeater ID="repTraOff" runat="server">
                                        <HeaderTemplate>
                                            <table class="table">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Panel runat="server" Visible='<%# Container.ItemIndex == 0 %>'>
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
                                    <h3>Total Price(Rs):
                                    <asp:Label ID="txtTotal" runat="server" Text=""></asp:Label></h3>

                                    <h3>Total
                                    <asp:Label ID="txtPoint" runat="server" Text=""></asp:Label></h3>
                                </div>
                            </div>


                     

                            <div class="form-row">
                                <div class="name">Action Name</div>
                                <div class="value">
                                    <asp:TextBox ID="txtact" runat="server" class="name input--style-6" placeholder="Action name" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtact" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                </div>
                            </div>


                            <asp:Panel ID="pnlCourtDate" Visible="false" CssClass="form-row" runat="server">
                                <div class="name">Court Date</div>
                                <div class="value">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtcourt" runat="server" placeholder="Court Date" class="input--style-6" ReadOnly="true" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtcourt" runat="server" Operator="LessThan" Type="Date" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    </div>
                                </div>
                            </asp:Panel>

                            <div class="form-row">
                                <div class="name">Offence Comments</div>
                                <div class="value">
                                    <div class="input-group">
                                        <asp:TextBox cols="20" Rows="2" ID="txtCom" runat="server" class="name input--style-6" placeholder=".." ReadOnly="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtCom" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                              <div class="form-row">
                                <div class="name">Action Comments</div>
                                <div class="value">
                                    <div class="input-group">
                                        <asp:TextBox cols="20" Rows="2" ID="txtactcmt" runat="server" class="name input--style-6" placeholder=".." ReadOnly="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtactcmt" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                            </div>

                            <div class="form-row">
                                <div class="name">Officer name</div>
                                <div class="value">
                                    <asp:TextBox ID="txtofficer" runat="server" class="name input--style-6" placeholder="officer name" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                </div>
                            </div>


                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
