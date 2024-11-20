<%@ Page Title="" Language="C#" MasterPageFile="~/police.Master" AutoEventWireup="true" CodeBehind="ReportViolation.aspx.cs" Inherits="Fine.forms.ReportViolation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Report Violation</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>
    <style>
        .floater {
            float: left;
            border: solid 1px black;
            padding: 5px;
            margin: 5px;
        }
    </style>
    <link href="../Content/leaflet/leaflet.css" rel="stylesheet" />
    <script src="../Content/leaflet/leaflet.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">

                <div class="card-body">
                    <div class="form">
                        <div class="card-heading">
                            <h2 class="title" style="color: black">Report Violation</h2>
                        </div>
                        <div class="form-row">
                         <asp:Label ID="lblactstatus" runat="server"></asp:Label>
                        </div>
                        <div class="form-row">
                            <div class="name">Search Driver</div>
                            <div class="value">
                                <asp:Button ID="btnselcus" OnClick="btnselcus_Click" CausesValidation="false" runat="server" CssClass="btn btn-block btn-dark float-left" Text="Select Driver" />
                                <asp:Panel ID="pnlselcus" Visible="false" runat="server">
                                    <div class="form-group">
                                        <input class="form-control" id="myInput" type="text" placeholder="Search.." />
                                        <asp:ListBox ID="lbcus" OnSelectedIndexChanged="lbcus_SelectedIndexChanged" AutoPostBack="true" class="form-control" Rows="5" runat="server"></asp:ListBox>
                                    </div>
                                </asp:Panel>
                                <br />
                                 <div class="form-row">
                                <asp:Label runat="server" ID="cusName"></asp:Label>
                                     </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Violation Name</div>
                            <div class="value">
                                <asp:TextBox ID="txtvio" runat="server" class="name input--style-6" placeholder="violation name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFname" ControlToValidate="txtvio" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtvio" ValidationExpression="^[a-zA-Z\s ]+$" runat="server" ErrorMessage="Only Letters"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <asp:Label ID="Label1" runat="server"></asp:Label>
                        <div class="form-row">
                            <div class="name">Traffic Offence</div>
                            <div class="value">
                                <div class="floater">

                                    <asp:UpdatePanel ID="upPrice" runat="server">
                                        <ContentTemplate>
                                            <asp:CheckBoxList ID="CheckBoxList1" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged" AutoPostBack="true" runat="server" />
                                            <asp:Label ID="lblTPrice" runat="server" Text="Price(Rs): 0" CssClass="m-3" Font-Size="Larger"></asp:Label>

                                            <asp:Label ID="txtPoint" runat="server" Text="Point: 0" CssClass="m-3" Font-Size="Larger"></asp:Label>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="CheckBoxList1" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Address Location</div>
                            <div class="value">
                                <div class="input-group">
                                    <div id="mapid" style="width: 100%; height: 400px;" class="container shadow-lg border-warning pb-3"></div>
                                    <script>
                                        $(document).ready(function () {//user click on button
                                            if ("geolocation" in navigator) { //check geolocation available 
                                                //try to get user current location using getCurrentPosition() method
                                                navigator.geolocation.getCurrentPosition(function (position) {
                                                    console.log("Found your location \nLat : " + position.coords.latitude + " \nLang :" + position.coords.longitude);


                                                    $("#ContentPlaceHolder1_hfLat").val(position.coords.latitude);
                                                    $("#ContentPlaceHolder1_hfLong").val(position.coords.longitude);

                                                    var mymap = L.map('mapid').setView([position.coords.latitude, position.coords.longitude], 13);
                                                    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
                                                        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                                                        maxZoom: 18,
                                                        id: 'mapbox/streets-v11',
                                                        tileSize: 512,
                                                        zoomOffset: -1,
                                                        accessToken: 'pk.eyJ1IjoiamltbXllbmZvaXJlcyIsImEiOiJjazhjenNvZncwcXJuM3J0cWE0bXpnY3c2In0.-cJHK7Txoekl8wA44xOnew'
                                                    }).addTo(mymap);
                                                    var marker = L.marker([position.coords.latitude, position.coords.longitude]).addTo(mymap);
                                                    marker.bindPopup("Hello am here!!").openPopup();

                                                });
                                            } else {
                                                console.log("Browser doesn't support geolocation!");
                                            }



                                        });
                                    </script>

                                    <asp:HiddenField ID="hfLat" runat="server" />
                                    <asp:HiddenField ID="hfLong" runat="server" />

                                    <div class="form-label-group">
                                        <asp:TextBox ID="txtAdd" Visible="false" runat="server" class="name" placeholder="Address"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="form-row">
                            <div class="name">Comments</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox cols="20" Rows="2" ID="txtCom" runat="server" class="name input--style-6" placeholder=".."></asp:TextBox>

                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txtCom" ValidationExpression="^[a-zA-Z0-9 ]*$" runat="server" ErrorMessage="Only Letters and number"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>


                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Register" OnClick="btnRegister_Click" />
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnCancel" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />



                        </div>
                       
                        <script>
                            /* When the user clicks on the button,
                            toggle between hiding and showing the dropdown content */
                            $(document).ready(function () {
                                $("#myInput").on("keyup", function () {
                                    var value = $(this).val().toLowerCase();
                                    $("#ContentPlaceHolder1_lbcus option").filter(function () {
                                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                                    });
                                });
                            });
                        </script>


                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
