<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calendar.aspx.cs" Inherits="Fine.forms.calendar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Calendar</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="../cal/dist/simple-calendar.css" />
    <link rel="stylesheet" href="../cal/assets/demo.css" />


    <link href="../registration/css/main.css" rel="stylesheet" media="all" />
    <script src="../registration/vendor/jquery/jquery.min.js"></script>


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
                            <h2 class="title center" style="color: black">Driver Calendar</h2>
                        </div>


                        <div id="container" class="calendar-container"></div>

                        <div class="card-footer">
                            <asp:Button ID="btnRegister" runat="server" class="btn btn--radius-2 btn--blue-2" Text="Back" CausesValidation="false" OnClick="btnRegister_Click" />
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
    <script src="../cal/dist/jquery.simple-calendar.js"></script>
    <script>
        $(document).ready(function () {
            $("#container").simpleCalendar({
                fixedStartDay: 1, // begin weeks by monday
                disableEmptyDetails: true,
                events: [
                    <%=outside%>
                ],

            });
        });
    </script>
    
</body>
</html>
