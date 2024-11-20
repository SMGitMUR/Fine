<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="viewpolice.aspx.cs" Inherits="Fine.forms.viewpolice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css" />
    <script src="../Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"> </script>

    <style>
        .showHide {
            cursor: pointer;
        }
    </style>

    <script type="text/javascript">         
        $(document).ready(function () {
            jQuery.noConflict();
            $.ajax({
                type: "post", dataType: "json", url: "viewpolicews.asmx/GetUsers", success: function (data) {

                    var datatableVariable = $('#userTable').DataTable(
                        {
                            data: data, columns:
                                [
                                    {
                                        'data': 'po_fname'
                                    },
                                    {
                                        'data': 'po_lname'
                                    },
                                    {
                                        'data': 'po_email'
                                    },
                                    {
                                        'data': 'po_phone'
                                    },
                                    {
                                        'data': 'po_num'
                                    },
                                    {
                                        'data': 'po_nic'
                                    }
                                ]
                        });
                    $('#userTable tfoot th').each(function () {
                        var placeHolderTitle = $('#userTable thead th').eq($(this).index()).text();
                        $(this).html('<input type="text" class="form-control input input-sm" placeholder = "Search ' + placeHolderTitle + '" />');
                    });
                    datatableVariable.columns().every(function () {
                        var column = this;
                        $(this.footer()).find('input').on('keyup change ', function () {
                            column.search(this.value).draw();
                        });
                    });
                    $('.showHide').on(' click ', function () {
                        var tableColumn = datatableVariable.column($(this).attr('data-columnindex'));
                        tableColumn.visible(!tableColumn.visible());
                    });
                }
            });

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-8">
        <h2>View & Search <b>police officers</b></h2>
    </div>
    <div style="padding: 10px; border: 5px solid black; margin-top: 50px" class="containerfluid">
        <div>
            <b class="label label-danger" style="padding: 8.5px">Click to Show or Hide Column:</b>
            <div class="btn-group btn-group-sm">
                <a class="showHide btn btn-primary" data-columnindex="0">Firstname</a>
                <a class="showHide btn btn-primary" data-columnindex="1">Lastname</a>
                <a class="showHide btn btn-primary" data-columnindex="2">email</a>
                <a class="showHide btn btn-primary" data-columnindex="3">phone</a>
                <a class="showHide btn btn-primary" data-columnindex="4">Badge Number</a>
                <a class="showHide btn btn-primary" data-columnindex="5">NIC</a>
                
            </div>
        </div>
        <br />
        <table id="userTable" style="width: 100%" class="table table-responsive table-striped table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Badge Number </th>
                    <th>NIC</th>
                   

                </tr>
            </thead>
            <%--<tfoot>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>LIC</th>
                    <th>NIC</th>
                    <th>Address</th>
                    <th>Date</th>

                </tr>
            </tfoot>--%>
        </table>
    </div>
</asp:Content>
