<%@ Page Title="" Language="C#" MasterPageFile="~/driver.Master" AutoEventWireup="true" CodeBehind="driverpersonal.aspx.cs" Inherits="Fine.forms.driverpersonal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Driver Personal Details</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">

                <div class="card-body">
                    <div class="form">
                        <div class="card-heading">
                            <h2 class="title" style="color: black">Driver Profile</h2>
                        </div>

                              <div class="form-row">
                            <div class="name">Driver Profile Picture</div>
                            <div class="value">

                                <div class="col-6">
                                    <div class="profile">
                                        <div class="card-body">
                                            <asp:Image ID="imgPP" Height="100" runat="server" />

                                        </div>
                                    </div>
                                </div>
                                <asp:FileUpload visible="false" Style="margin: 0" ID="fup_pp" ClientIDMode="Static" onchange="img();" CssClass="form-control" runat="server" />

                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Driver Firstname:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtfname" runat="server" placeholder="Firstname" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Driver Lastname:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtlname" runat="server" placeholder="Lastname" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>


                        <div class="form-row">
                            <div class="name">Driver email:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtemail" runat="server" placeholder="Email" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>


                        <div class="form-row">
                            <div class="name">Driver Phone Number:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtphone" runat="server" placeholder="Phone Number" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>


                         <div class="form-row">
                            <div class="name">Driver License Number:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtlic" runat="server" placeholder="License Number" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>


                         <div class="form-row">
                            <div class="name">Driver NIC Number:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtNIC" runat="server" placeholder="NIC Number" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>


                         <div class="form-row">
                            <div class="name">Driver Address:</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtadd" runat="server" placeholder="Address" class="input--style-6" ReadOnly="true" />
                                  
                                </div>
                            </div>
                        </div>

              

                        <div class="form-row">
                            <div class="name">License Own</div>
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
                                            <th scope="col">License</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                </asp:Panel>
                                <tr>
                                    <td><%# Container.ItemIndex %></td>
                                    <td><%# Eval("license") %></td>
                                   
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                                </asp:Repeater>
                                
                            </div>
                        </div>

                         <div class="card-footer">
                            <asp:Button ID="btnUpdate" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Update Profile" CausesValidation="false" OnClick="btnUpdate_Click" />
                        </div>


                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
