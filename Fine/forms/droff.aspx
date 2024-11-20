<%@ Page Title="" Language="C#" MasterPageFile="~/driver.Master" AutoEventWireup="true" CodeBehind="droff.aspx.cs" Inherits="Fine.forms.droff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

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
                type: "post", dataType: "json", url: "viewdroffasmx.asmx/GetUsers", data: { drId: <%=Session["dr_id"].ToString()%>}, success: function (data) {

                    var datatableVariable = $('#userTable').DataTable(
                        {
                            data: data, columns:
                                [
                                    {
                                        'data': 'vio_name'
                                    },
                                    {
                                        'data': 'vio_comment'
                                    },
                                    {
                                        'data': 'vio_date'
                                    }, {
                                        'data': 'vio_point'
                                    },
                                    {
                                        'data': 'vio_id', render: function (data, type, row) {
                                            return '<a href="viewdetails?id=' + data + '">click</a>';
                                        }
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
                    let count = 0;
                    $('#userTable tbody tr td:nth-child(4)').each(function () {
                        //add item to array
                        count += parseInt($(this).text().split(':')[1]);
                    });
                    $('.totalCount').text('Total Points: ' + count);
                }
            });

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-8">
        <h2>View & Search <b>Offences</b></h2>
    </div>
    <div style="padding: 10px; border: 5px solid black; margin-top: 50px" class="containerfluid">
        <div>
            <b class="label label-danger" style="padding: 8.5px">Click to Show or Hide Column:</b>
            <div class="btn-group btn-group-sm">
                <a class="showHide btn btn-primary" data-columnindex="0">Name</a>
                <a class="showHide btn btn-primary" data-columnindex="1">Comment</a>
                <a class="showHide btn btn-primary" data-columnindex="2">Date</a>
                <a class="showHide btn btn-primary" data-columnindex="3">Vio Point</a>
                <a class="showHide btn btn-primary" data-columnindex="4">More Info</a>
            </div>
        </div>
        <br />


          <h3>Please note that if total points exceeds 100 <b>your license will be revoked.</b></h3>
        <h2>
            <label class="totalCount"></label>
        </h2>

    
        <table id="userTable" style="width: 100%" class="table table-responsive table-striped table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Vio Name</th>
                    <th>Vio Comment</th>
                    <th>Vio Date</th>
                    <th>Vio Point</th>
                    <th>More info</th>

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
