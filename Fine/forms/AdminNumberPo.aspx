<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="AdminNumberPo.aspx.cs" Inherits="Fine.forms.AdminNumberPo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chart</title>
    <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../chart/simple-chart.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,600|Lato:300, 400i,700,700i" rel="stylesheet">
    <style>
        body {
            background-color: #eaeff5
        }

        section {
            float: left;
            width: 100%;
            padding: 10px;
            margin: 40px 0;
          
            box-shadow: 0 15px 40px rgba(0,0,0,.1)
        }

        h1 {
            margin-top: 150px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container-fluid">

        <section class="sc-section">
            <div class="bar-chart"></div>
        </section>

    </div>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="../chart/simple-chart.js"></script>
    <script>
        function abbreviateNumber(arr) {
            var newArr = [];
            $.each(arr, function (index, value) {
                var newValue = value;
                if (value >= 1000) {
                    var suffixes = [" ", " K", " mil", " bil", " t"];
                    var suffixNum = Math.floor(("" + value).length / 3);
                    var shortValue = '';
                    for (var precision = 2; precision >= 1; precision--) {
                        shortValue = parseFloat((suffixNum !== 0 ? (value / Math.pow(1000, suffixNum)) : value).toPrecision(precision));
                        var dotLessShortValue = (shortValue + '').replace(/[^a-zA-Z 0-9]+/g, '');
                        if (dotLessShortValue.length <= 2) {
                            break;
                        }
                    }
                    if (shortValue % 1 !== 0) shortNum = shortValue.toFixed(1);
                    newValue = shortValue + suffixes[suffixNum];
                }
                newArr[index] = newValue;
            });
            return newArr;
        }


        var labels = [<%=labels%>];
        var values = [<%=values%>];
        var outputValues = abbreviateNumber(values);


        $('.bar-chart').simpleChart({
            title: {
                text: 'Total Number Of Traffic Offence Registration',
                align: 'center'
            },
            type: 'bar',
            layout: {
                width: '100%'
            },
            item: {
                label: labels,
                value: values,
                outputValue: outputValues,
                color: ['#00aeef'],
                prefix: 'Total:',
                suffix: '',
                render: {
                    margin: 0,
                    size: 'relative'
                }
            }
        });


    </script>
</asp:Content>
