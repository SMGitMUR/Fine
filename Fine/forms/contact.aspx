<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="Fine.forms.contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Contact Us</title>

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
</head>
<body>

    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">

                <div class="card-body">
                    <form id="form1" runat="server">

                        <div class="card-heading">
                            <h2 class="title" style="color: black">Contact Us</h2>
                        </div>
                        <div class="form-row">
                        <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                            </div>
                        <div class="form-row">
                            <div class="name">Fullname</div>
                            <div class="value">
                                <asp:TextBox ID="txtfirst" runat="server" class="name input--style-6" placeholder="Fullname"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFname" ControlToValidate="txtfirst" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtfirst" ValidationExpression="^[a-zA-Z\s ]+$" runat="server" ErrorMessage="Only Letters"></asp:RegularExpressionValidator>
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
                            <div class="name">Subject</div>
                            <div class="value">
                                <asp:TextBox ID="txtsubject" runat="server" class="name input--style-6" placeholder="Enter Subject"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvlast" ControlToValidate="txtsubject" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txtsubject" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Message</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox cols="20" Rows="2" ID="txtCom" runat="server" class="name input--style-6" placeholder="Enter Your Message"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtCom" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtCom" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
                            </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Register" OnClick="btnRegister_Click" />
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnCancel" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />
                        </div>
                          <div class="row">


                            <a href="index.aspx" class="txt1">Back</a>

                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
