<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Registration.aspx.cs" Inherits="EmmasWebApp.Registration" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %> </h2>
    <h2>User Registration</h2>
    <div class="settings">
        
        <label>Username</label>
        <asp:TextBox ID="txtUsername" AutoCompleteType="Disabled" runat="server"></asp:TextBox>

        <label>Password</label>
        <asp:TextBox ID="txtPassword" type="password" AutoCompleteType="Disabled" runat="server"></asp:TextBox>

        <label>Confirm Password</label>
        <asp:TextBox ID="txtPWConfirm" type="password" AutoCompleteType="Disabled" runat="server"></asp:TextBox>
    </div>
    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
    
    <br />
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
    <br />
    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtPWConfirm" ErrorMessage="Password does not match" SetFocusOnError="True"></asp:CompareValidator>
    
    <p>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required" SetFocusOnError="True"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" SetFocusOnError="true"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPWConfirm" ErrorMessage="You must confirm password" SetFocusOnError="True"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
