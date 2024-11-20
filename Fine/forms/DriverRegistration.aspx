<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DriverRegistration.aspx.cs" Inherits="Fine.forms.DriverRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Required meta tags-->
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Driver Registration</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />

    <style>
        .floater {
            float: left;
            border: solid 1px black;
            padding: 5px;
            margin: 5px;
        }
    </style>
</head>

<body>
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Driver Registration</h2>
                </div>
                <div class="card-body">
                    <form runat="server">
                        <div class="form-row">
                         <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                            </div>
                        <div class="form-row">
                            <div class="name">Firstname</div>
                            <div class="value">
                                <asp:TextBox ID="txtfirst" runat="server" class="name input--style-6" placeholder="firstname"></asp:TextBox>
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtNIC" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtNIC" ValidationExpression="^[0-9a-zA-Z]{14}$" runat="server" ErrorMessage="14 digits required 1 letter and 13 number"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Address</div>
                            <div class="value">
                                <asp:TextBox ID="txtAdd" runat="server" class="name input--style-6" placeholder="Address"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtAdd" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txtAdd" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Username</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtuser" runat="server" class="name input--style-6" placeholder="username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtuser" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtuser" ValidationExpression="^[a-zAZ](.{1,9})$" runat="server" ErrorMessage="Username must be between 2 to 10 characters"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Email</div>
                            <div class="value">
                                <asp:TextBox ID="txtEmail" runat="server" placeholder=" E-mail" Class="input--style-6" />
                                <asp:RequiredFieldValidator ID="reqEmail" ControlToValidate="txtEmail" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                <asp:RegularExpressionValidator ID="RegEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.’]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Not Valid"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Mobile or Telephone Number</div>
                            <div class="value">
                                <asp:TextBox ID="txtPnum" runat="server" MaxLength="8" class="number input--style-6" placeholder=" Phone"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPnum" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtPnum" ErrorMessage="Either Telephone(7 digits) or phone(8 digits) " ForeColor="red" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtPnum" ValidationExpression="^(0|[1-9]\d*)$" ErrorMessage="Numeric Only"></asp:RegularExpressionValidator>
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
                                    <asp:TextBox ID="txtPassWord" runat="server" TextMode="Password" placeholder="confirm password" class="input--style-6" />
                                    <asp:RequiredFieldValidator ID="ReqCpassword" ControlToValidate="txtPassWord" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                    <asp:CompareValidator ID="conPassword" runat="server" ControlToCompare="txtPass" ControlToValidate="txtPassWord" ErrorMessage="Password does not match"></asp:CompareValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">License Number</div>
                            <div class="value">
                                <asp:TextBox ID="txtNum" runat="server" MaxLength="6" class="number input--style-6" placeholder="License Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtNum" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtNum" ErrorMessage="6 digits required " ForeColor="red" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtNum" ErrorMessage="6 digits required" ValidationExpression="[0-9]{6}"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">License Date Issued</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtDate" runat="server" Type="Date" placeholder="Date" class="input--style-6" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtDate" runat="server" ErrorMessage="Date should not greater than today" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lbldate" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <div>
                            <div class="form-row pb-3" style="width: 100%; height: 400px;">
                                <div class="name">Please Select License Type You Own</div>
                                <div class="floater">

                                    <asp:CheckBoxList ID="CheckBox1" runat="server" Width="200px">
                                        <asp:ListItem>Motorcycle</asp:ListItem>
                                        <asp:ListItem>Private Car</asp:ListItem>
                                        <asp:ListItem>Taxi</asp:ListItem>
                                        <asp:ListItem>Goods Vehicle</asp:ListItem>
                                        <asp:ListItem>Tractor On Tyres</asp:ListItem>
                                        <asp:ListItem>Bus</asp:ListItem>
                                        <asp:ListItem>Heavy Motor Vehicle</asp:ListItem>
                                        <asp:ListItem>Other Type</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                        </div>





                        <div class="form-row">
                            <div class="name">Comments</div>
                            <div class="value">
                                <div class="input-group col-12">
                                    <asp:TextBox cols="30" Rows="6" ID="txtCom" runat="server" class="name textarea--style-6" placeholder=".."></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txtCom" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
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
                        </div>

                       

                        <div class="row">


                            <a href="viewdriver.aspx" class="txt1">Back</a>

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
