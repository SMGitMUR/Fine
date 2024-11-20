<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetOfficer.aspx.cs" Inherits="Fine.forms.ResetOfficer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Officer Forget Password</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>

</head>
<body>
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Lost your password? Please enter your email address and badge number. You will receive a verification code to create a new password via email</h2>
                </div>
                <div class="card-body">
                    <form runat="server">

                        <asp:Panel ID="pnlemail" CssClass="form-row" runat="server">
                            <div class="element-main">


                                <div class="form-row">
                                    <asp:TextBox ID="txbfemail" TextMode="Email" placeholder="Email" class="name input--style-6" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqEmail" ControlToValidate="txbfemail" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    <asp:RegularExpressionValidator ID="RegEmail" runat="server" ControlToValidate="txbfemail" ValidationExpression="\w+([-+.’]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Not Valid"></asp:RegularExpressionValidator>
                                </div>

                                <div class="form-row">
                                    <asp:TextBox ID="txtuser" runat="server" class="name input--style-6" placeholder="Badge Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvuser" ControlToValidate="txtuser" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtuser" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Username must be between 2 to 10 characters"></asp:RegularExpressionValidator>


                                </div>
                                <div class="form-row">
                                    <asp:Button ID="btnreset" OnClick="btnreset_Click" CssClass="btn btn--radius-2 btn--blue-2" runat="server" Text="Reset my Password" />
                                </div>

                                <asp:Label ID="lblerror" ForeColor="Red" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnlpass" Visible="false" runat="server" CssClass="form-row">
                            <div class="element-main">
                                <asp:Label ID="lblmessage" runat="server" Text=""></asp:Label>



                                <div class="form-row">
                                    <div class="name">Activation Key</div>
                                    <div class="value">
                                        <div class="input-group">
                                            <asp:TextBox ID="txbactkey" placeholder="Activation Key" runat="server" class="name input--style-6"></asp:TextBox>

                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txbactkey" ValidationExpression="^(0|[1-9]\d*)$" ErrorMessage="Numeric Only"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="name">New Password</div>
                                    <div class="value">
                                        <div class="input-group">
                                            <asp:TextBox ID="txbfpass" TextMode="Password" placeholder="Password" runat="server" class="name input--style-6"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqPassword" ControlToValidate="txbfpass" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                            <asp:RegularExpressionValidator ID="regPassword" ControlToValidate="txbfpass" ValidationExpression="^(?=.*\d{2})(?=.*[a-zA-Z]{2}).{8,}$" runat="server" ErrorMessage="Password Not Strong"></asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>



                                <div class="form-row">
                                    <div class="name">New Password</div>
                                    <div class="value">
                                        <div class="input-group">
                                            <asp:TextBox ID="txbfcpass" TextMode="Password" placeholder="Confirm Password" runat="server" class="name input--style-6"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="ReqCpassword" ControlToValidate="txbfcpass" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                            <asp:CompareValidator ID="conPassword" runat="server" ControlToCompare="txbfpass" ControlToValidate="txbfcpass" ErrorMessage="Password does not match"></asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>



                                <div class="form-row">

                                    <asp:Button ID="btnsave" OnClick="btnsave_Click" CssClass="btn btn--radius-2 btn--blue-2" runat="server" Text="Save Password" />
                                </div>
                                
                                    <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                               
                            </div>
                        </asp:Panel>
                        <a href="PoliceLogin.aspx" class="txt1">Back</a>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!-- Jquery JS-->
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>

</body>

</html>
