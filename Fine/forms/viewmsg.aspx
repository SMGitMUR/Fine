<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="viewmsg.aspx.cs" Inherits="Fine.forms.viewmsg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Message Details</title>

    <!-- Font special for pages-->
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

                <div class="card-body">
                    <div class="form">
                        <div class="card-heading">
                            <h2 class="title" style="color: black">Messages</h2>
                        </div>
                        <div class="form-row">
                            <div class="value table-responsive">
                                
                                    <asp:Repeater ID="repTraOff" runat="server">
                                         <HeaderTemplate>
                                            <table class="table">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Panel runat="server" Visible='<%# Container.ItemIndex == 0 %>'>
                                                <thead>
                                                    <tr>
                                                        <th scope="col">#</th>
                                                        <th scope="col">Date:</th>
                                                        <th scope="col">Name:</th>
                                                        <th scope="col">Email:</th>
                                                        <th scope="col">Subject:</th>
                                                        <th scope="col">Message:</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                            </asp:Panel>
                                            <tr>
                                                <td><%# Container.ItemIndex %></td>
                                                <td><%# Eval("ca_dateentry", "{0:dd  MMMM  yyyy hh:mm tt}") %></td>
                                                <td><%# Eval("ca_name") %></td>
                                                <td><%# Eval("ca_email") %></td>
                                                 <td><%# Eval("ca_subject") %></td>
                                                <td><%# Eval("ca_message") %></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                                </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                           
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
 
</asp:Content>
