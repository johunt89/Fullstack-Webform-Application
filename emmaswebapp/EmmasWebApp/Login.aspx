<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="EmmasWebApp.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %> </h2>
    <h2>Login</h2>
    <div class="settings">
        
        <label>Username</label>
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

        <label>Password</label>
        <asp:TextBox ID="txtPassword" type="password" AutoCompleteType="Disabled" runat="server"></asp:TextBox>

        &nbsp;</div>
    <asp:Button ID="btnLogin" ValidatioNGroup="textValidator" runat="server" OnClick="btnLogin_Click" Text="Login" />
    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
    
    <br />
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidatioNGroup="textValidator" runat="server" ControlToValidate="txtUsername" ErrorMessage="You must provide a Username" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidatioNGroup="textValidator" runat="server" ControlToValidate="txtPassword" ErrorMessage="You must enter a password" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <br />
    </asp:Content>
