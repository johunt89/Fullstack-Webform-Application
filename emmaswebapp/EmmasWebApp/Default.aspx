<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EmmasWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Emma&#39;s Small Engines</h1>
        <p class="lead">Welcome, get started below by choosing what you would like to do</p>
        <p>&nbsp;</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Customers</h2>
            <p>
                <a class="btn btn-default" href="Customers">Lets Go &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Inventory</h2>
            <p>
                <a class="btn btn-default" href="Inventory">Lets Go &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Orders</h2>
            <p>
                <a class="btn btn-default" href="Orders">Lets Go &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
