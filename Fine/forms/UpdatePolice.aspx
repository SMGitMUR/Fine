<%@ Page Title="" Language="C#" MasterPageFile="~/police.Master" AutoEventWireup="true" CodeBehind="UpdatePolice.aspx.cs" Inherits="Fine.forms.UpdatePolice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Update Driver</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script>
        function img() {
            var preview = document.querySelector('#<%=imgPP.ClientID %>');
            var file = document.querySelector('#<%=fup_pp.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
        }
    </script>
    <!-- Jquery JS-->
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


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
                            <h2 class="title" style="color: black">Update Officer Profile</h2>
                        </div>
                        <div class="form-row">
                         <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                            </div>
                        <div class="form-row">
                            <div class="name">Update Your Profile Picture</div>
                            <div class="value">

                                <div class="col-6">
                                    <div class="profile">
                                        <div class="card-body">
                                            <asp:Image ID="imgPP" Height="100" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <asp:FileUpload Visible="false" Style="margin: 0" ID="fup_pp" ClientIDMode="Static" onchange="img();" CssClass="form-control" runat="server" />

                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Phone Number</div>
                            <div class="value">
                                <asp:TextBox runat="server" MaxLength="8" CssClass="form-control" ID="txtPnum" data-toggle="tooltip" data-placement="right" title="E.g: 59097467" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtPnum" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtPnum" ErrorMessage="Either Telephone(7 digits) or phone(8 digits) " ForeColor="red" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtPnum" ValidationExpression="^(0|[1-9]\d*)$" ErrorMessage="Numeric Only"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-row">
                            <asp:Button ID="btnreset" OnClick="btnreset_Click" CssClass="btn btn--radius-2 btn--blue-2" runat="server" Text="Change my Password" />
                        </div>

                        <asp:Panel ID="pnlpass" Visible="false" runat="server" CssClass="form-row">
                            <div class="element-main">
                                <asp:Label ID="lblmessage" runat="server" Text=""></asp:Label>
                                <div class="form-row">
                                    <div class="name">New Password</div>
                                    <div class="value">
                                        <asp:TextBox ID="U_password" runat="server" CssClass="form-control" TextMode="Password" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="U_password" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="U_password" ValidationExpression="^(?=.*\d{2})(?=.*[a-zA-Z]{2}).{8,}$" runat="server" ErrorMessage="Password Not Strong"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="name">Confirm New Password</div>
                                    <div class="value">
                                        <div class="input-group">
                                            <asp:TextBox ID="R_compass" runat="server" CssClass="form-control" TextMode="Password" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="R_compass" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="U_password" ControlToValidate="R_compass" ErrorMessage="Password does not match"></asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </asp:Panel>


                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Register" OnClick="btnRegister_Click" />
                        </div>


                       

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
