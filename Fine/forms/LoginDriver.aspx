<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginDriver.aspx.cs" Inherits="Fine.forms.LoginDriver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Driver</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="../login/images/icons/favicon.ico" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/bootstrap/css/bootstrap.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/animate/animate.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/css-hamburgers/hamburgers.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/animsition/css/animsition.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/select2/select2.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/vendor/daterangepicker/daterangepicker.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../login/css/util.css" />
    <link rel="stylesheet" type="text/css" href="../login/css/main.css" />
    <!--===============================================================================================-->
</head>
<body>
    <div class="form">
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-form-title" style="background-image: url(../login/images/driver.jpg);">
                        <span class="login100-form-title-1">Driver Sign In
                        </span>
                    </div>

                    <form runat="server" class="login100-form validate-form">
                        <div class="wrap-input100 validate-input m-b-26" data-validate="Username is required">
                            <span class="label-input100">Username</span>

                            <p>
                                <asp:TextBox ID="txtUsername" placeholder="username" runat="server"></asp:TextBox>
                            </p>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required." ForeColor="Red" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100 validate-input m-b-18" data-validate="Password is required">
                            <span class="label-input100">Password</span>

                            <p>
                                <asp:TextBox ID="txtPassword" placeholder="password" TextMode="Password" runat="server"></asp:TextBox>
                            </p>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required." ForeColor="Red" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                            <span class="focus-input100"></span>
                        </div>

                        <div class="flex-sb-m w-full p-b-30">
                            <div class="contact100-form-checkbox">


                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Remember me" />
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-6">
                                <asp:Button ID="btnlogin" runat="server" class="btn btn-success" OnClick="btnlogin_Click" Text="Log In" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btncancel" runat="server" class="btn btn-danger" Text="Cancel" OnClick="btnCancel_Click" />
                            </div>
                        </div>

                        <div class="row">


                            <a href="ResetDriver.aspx" class="txt1">Forget Password</a>

                        </div>
                        <a href="index.aspx" class="txt1">Back</a>

                         <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                    </form>

                </div>
            </div>
        </div>
    </div>
    <!--===============================================================================================-->
    <script src="../login/vendor/jquery/jquery-3.2.1.min.js"></script>
    <!--===============================================================================================-->
    <script src="../login/vendor/animsition/js/animsition.min.js"></script>
    <!--===============================================================================================-->
    <script src="../login/vendor/bootstrap/js/popper.js"></script>
    <script src="../login/vendor/bootstrap/js/bootstrap.min.js"></script>
    <!--===============================================================================================-->
    <script src="../login/vendor/select2/select2.min.js"></script>
    <!--===============================================================================================-->
    <script src="../login/vendor/daterangepicker/moment.min.js"></script>
    <script src="../login/vendor/daterangepicker/daterangepicker.js"></script>
    <!--===============================================================================================-->
    <script src="../login/vendor/countdowntime/countdowntime.js"></script>
    <!--===============================================================================================-->
    <script src="../login/js/main.js"></script>

</body>
</html>
