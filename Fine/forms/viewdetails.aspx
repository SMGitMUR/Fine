<%@ Page Title="" Language="C#" MasterPageFile="~/driver.Master" AutoEventWireup="true" CodeBehind="viewdetails.aspx.cs" Inherits="Fine.forms.viewdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Title Page-->
    <title>Violation Details</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet" />

    <!-- Main CSS-->
    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


    <!-- Main JS-->
    <script src="../registration/js/global.js"></script>

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
                            <h2 class="title" style="color: black">Violation Details</h2>
                        </div>

                        <div class="form-row">
                            <h3><b>
                                <asp:Label ID="lblactstatus" runat="server"></asp:Label></b></h3>
                        </div>

                        <asp:Panel ID="Paypal" Visible="false" CssClass="form-row" runat="server">
                            <div class="name">Pay Now Using Paypal</div>
                            <div id="paypal-payment-button" class="form-row"></div>
                        </asp:Panel>



                        <div class="form-row">
                            <div class="name">Violation Date Issued</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtDate" runat="server" placeholder="Date" class="input--style-6" ReadOnly="true" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtDate" runat="server" Operator="LessThan" Type="Date" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                        </div>


                        <div class="form-row">
                            <div class="name">Violation Name</div>
                            <div class="value">
                                <asp:TextBox ID="txtvio" runat="server" class="name input--style-6" placeholder="violation name" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFname" ControlToValidate="txtvio" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Traffic Offence</div>
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
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Price(Rs)</th>
                                                    <th scope="col">Point</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        </asp:Panel>
                                        <tr>
                                            <td><%# Container.ItemIndex %></td>
                                            <td><%# Eval("cat_name") %></td>
                                            <td><%# Eval("cat_price") %></td>
                                            <td><%# Eval("cat_point") %></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <h3>Total Price Rs: 
                                    <asp:Label ID="txtTotal" runat="server" Text=""></asp:Label></h3>

                                <h3>Total Points:
                                    <asp:Label ID="txtPoint" runat="server" Text=""></asp:Label></h3>
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
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtAdd" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="name">Offence Comments</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox cols="20" Rows="2" ID="txtCom" runat="server" class="name input--style-6" placeholder=".." ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtCom" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>




                        <div class="form-row">
                            <div class="name">Action Name</div>
                            <div class="value">
                                <asp:TextBox ID="txtact" runat="server" class="name input--style-6" placeholder="Action name" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtact" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>
                        </div>


                        <asp:Panel ID="pnlCourtDate" Visible="false" CssClass="form-row" runat="server">
                            <div class="name">Court Date</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox ID="txtcourt" runat="server" placeholder="Court Date" class="input--style-6" ReadOnly="true" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtcourt" runat="server" Operator="LessThan" Type="Date" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator><br />
                                </div>
                            </div>
                        </asp:Panel>


                        <div class="form-row">
                            <div class="name">Action Comments</div>
                            <div class="value">
                                <div class="input-group">
                                    <asp:TextBox cols="20" Rows="2" ID="txtactcmt" runat="server" class="name input--style-6" placeholder=".." ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtactcmt" runat="server" ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>


                        <div class="form-row">
                            <div class="name">Officer name</div>
                            <div class="value">
                                <asp:TextBox ID="txtofficer" runat="server" class="name input--style-6" placeholder="officer name" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>
                        </div>


                        <asp:Panel ID="Panel1" Visible="false" CssClass="form-row" runat="server">
                            <div class="name">Action ID</div>
                            <div class="value">
                                <asp:TextBox ID="txtID" runat="server" class="name input--style-6" placeholder="Action name" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="txtID" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>

                            <div class="name">Driver ID</div>
                            <div class="value">
                                <asp:TextBox ID="txtDRID" runat="server" class="name input--style-6" placeholder="Driver ID" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="paypanel" Visible="false" CssClass="form-row" runat="server">

                            <div class="name">Payment Method</div>
                            <div class="value">
                                <asp:TextBox ID="txtmethod" runat="server" class="name input--style-6" placeholder="Payment Method" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>



                            <div class="name">Payment Date</div>
                            <div class="value">
                                <asp:TextBox ID="txtpaydate" runat="server" class="name input--style-6" placeholder="Payment Date" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>



                            <div class="name">Amount Paid</div>
                            <div class="value">
                                <asp:TextBox ID="txtpaid" runat="server" class="name input--style-6" placeholder="Amount Paid" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtofficer" runat="server" ErrorMessage="Required" ForeColor="red"></asp:RequiredFieldValidator>
                            </div>

                        </asp:Panel>


                        <div class="card-footer">
                            <asp:Button ID="btnBack" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Back" CausesValidation="false" OnClick="btnBack_Click" />
                        </div>

                    </div>
                </div>

                <input type="hidden" class="asas" id="myHiddenId" runat="server" />
                <input type="hidden" class="ssaa" id="myHiddenAmount" runat="server" />

            </div>
        </div>
    </div>
    <script src="https://www.paypal.com/sdk/js?client-id=Ac6rFkx3CsC8F7PWNXDqc-Wvg1i2QBiShWlGOtnkQKYVDHaGzi5DS07qClWMSann_F7lhNelgR16vkPV&currency=USD"></script>
    <script>
        var amount = $('.ssaa').val();
        console.log(amount);

        paypal.Buttons({
            createOrder: function (data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: amount/40
                        }
                    }]
                });
            },
            onApprove: function (data, actions) {
                return actions.order.capture().then(function (details) {
                    console.log(details.purchase_units[0].amount.value);

                    var idvalue = $('.asas').val();

                    $.post("PaymentDB.aspx?date=" + details.create_time + " &amount=" + details.purchase_units[0].amount.value + "&actionid=" + idvalue, function (data) {

                    });

                    alert('Transaction completed by ' + details.payer.name.given_name + '!');
                    window.location.href = "PaySuccess.aspx";
                })
            },
            onCancel: function (data) {
                window.location.href = "PayCancel.aspx";
            }
        }).render('#paypal-payment-button');

    </script>
</asp:Content>

