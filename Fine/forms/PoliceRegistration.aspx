<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PoliceRegistration.aspx.cs" Inherits="Fine.forms.PoliceRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags-->
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Police Registration</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
</head>

<body>
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Police Officer Registration</h2>
                </div>
                <div class="card-body">
                    <form runat="server">
                        <div class="form-row">
                          <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                            </div>
                        <div class="form-row">
                            <div class="name">Firstname</div>
                            <div class="value">
                                <asp:TextBox ID="txtfirst" runat="server" class="name input--style-6" placeholder="Firstname"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFname" ControlToValidate="txtfirst" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtfirst" ValidationExpression="^[a-zA-Z\s]+$" runat="server" ErrorMessage="Only Letters"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Lastname</div>
                            <div class="value">
                                <asp:TextBox ID="txtlast" runat="server" class="name input--style-6" placeholder="lastname"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvlast" ControlToValidate="txtlast" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="txtlast" ValidationExpression="^[a-zA-Z\s]+$" runat="server" ErrorMessage="Only Letters"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">NIC Number</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtNIC" runat="server" MaxLength="14" class="number input--style-6" placeholder="NIC Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtNIC" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtNIC" ValidationExpression="^[0-9a-zA-Z]{14}$" runat="server" ErrorMessage="14 digits required 1 letter and 13 number"></asp:RegularExpressionValidator>
                                  
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Username</div>
                            <div class="value">
                                <asp:TextBox ID="txtuser" runat="server" class="name input--style-6" placeholder="username"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvuser" ControlToValidate="txtuser" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtuser" ValidationExpression="^[a-zAZ](.{1,9})$" runat="server" ErrorMessage="Username must be between 2 to 10 characters"></asp:RegularExpressionValidator>

                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Email</div>
                            <div class="value">
                                <asp:TextBox ID="txtEmail" runat="server" placeholder=" E-mail" class="input--style-6" />
                                <asp:RequiredFieldValidator ID="reqEmail" ControlToValidate="txtEmail" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                <asp:RegularExpressionValidator ID="RegEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.’]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Not Valid"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Phone Number</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtPnum" runat="server" MaxLength="8" class="number input--style-6" placeholder=" Phone"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPnum" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtPnum" ValidationExpression="^(0|[1-9]\d*)$" ErrorMessage="Numeric Only"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Badge Number</div>
                            <div class="value">
                                <asp:TextBox ID="txtNum" runat="server" class="number input--style-6" placeholder="Badge Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtNum" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="REV1" ControlToValidate="txtNum" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Username must be between 2 to 10 characters"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Password</div>
                            <div class="value">
                                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" placeholder="password" Class="input--style-6" />
                                <asp:RequiredFieldValidator ID="reqPassword" ControlToValidate="txtPass" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                <asp:RegularExpressionValidator ID="regPassword" ControlToValidate="txtPass" ValidationExpression="^(?=.*\d{2})(?=.*[a-zA-Z]{2}).{8,}$" runat="server" ErrorMessage="Password Not Strong"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Confirm Password</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtPassWord" runat="server" TextMode="Password" placeholder="confirm password" Class=" input--style-6" />
                                    <asp:RequiredFieldValidator ID="ReqCpassword" ControlToValidate="txtPassWord" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    <asp:CompareValidator ID="conPassword" runat="server" ControlToCompare="txtPass" ControlToValidate="txtPassWord" ErrorMessage="Password does not match"></asp:CompareValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Upload Profile Picture</div>
                            <div class="value">
                                <div class="input-group js-input-file">
                                    <asp:FileUpload ID="FileUpload2" ValidationGroup="seek" runat="server" />
                                    <label class="label--file" for="file">Upload Profile Picture</label>

                                </div>
                                <div class="label--desc">Upload your Profile Picture. Max file size 50 MB</div>
                            </div>
                        </div>

                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Register" OnClick="btnRegister_Click" />
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnCancel" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Clear" CausesValidation="false" OnClick="btnCancel_Click" />


                            <a href="viewpolice.aspx" class="txt1">Back</a>
                        </div>

                      

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
