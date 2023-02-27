<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="EmmasWebApp.Customers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>Filters:</h3>
    <div class="settings">

        <label>Name</label>
        <asp:TextBox ID="txtCustomerSearch" runat="server" AutoPostBack="True"></asp:TextBox>

        <label>City</label>
        <asp:DropDownList ID="ddlCustomerCity" runat="server" AutoPostBack="True" DataSourceID="cityDataSource" DataTextField="custCity" DataValueField="custCity" OnDataBound="DdlChanged" Height="32px" Width="122px"></asp:DropDownList>
    
    </div>

    
    <p>
        &nbsp;</p>
    <div class="customerButtons">
        <asp:Button ID="btnSearch" runat="server" Text="Search" />
        <asp:Button ID="btnClearFilters" runat="server" Text="Clear" OnClick="btnClearFilters_Click" />
        <asp:Button ID="btnDisplayAdd" runat="server" Text="New" OnClick="btnDisplayAdd_Click" />
    </div>
    <div runat="server" id="customerAddSection" class="newCustomer settings">
        <fieldset>
            <legend>Create Customer</legend>
            <label>First Name</label>
            <asp:TextBox ID="txtFirstInput" name="first" runat="server"></asp:TextBox>

            <label>Last Name</label>
            <asp:TextBox ID="txtLastInput" runat="server"></asp:TextBox>
            
            <label>Address</label>
            <asp:TextBox ID="txtAddressInput" runat="server"></asp:TextBox>

            <label>City</label>
            <asp:TextBox ID="txtCityInput" runat="server"></asp:TextBox>

            <label>Postal Code</label>
            <asp:TextBox ID="txtPostInput" runat="server"></asp:TextBox>

            <label>Phone Number</label>
            <asp:TextBox ID="txtPhoneInput" runat="server"></asp:TextBox>

            <label>Email Address</label>
            <asp:TextBox ID="txtEmailInput" runat="server"></asp:TextBox>

            <asp:Button ID="btnAddCustomer" runat="server" Text="Add" OnClick="btnAddCustomer_Click" />
            <asp:Button ID="btnClearAddInputs" runat="server" Text="Cancel" OnClick="btnClearAddInputs_Click" />

            
        </fieldset>
            
    </div>
    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
    <p>
        <asp:GridView ID="gvCustomerInfo" runat="server" AutoGenerateColumns="False" Height="151px" Width="870px" AllowPaging="True" DataKeyNames="id" DataSourceID="CustomerDataSource" OnSelectedIndexChanged="gvCustomerInfo_SelectedIndexChanged" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8" OnRowDeleted="gvCustomerInfo_RowDeleted" OnRowUpdated="gvCustomerInfo_RowUpdated">
            <Columns>
                <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this customer?');"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="custFirst" HeaderText="First Name" SortExpression="custFirst" />
                <asp:BoundField DataField="custLast" HeaderText="Last Name" SortExpression="custLast" />
                <asp:BoundField DataField="custPhone" HeaderText="Phone #" SortExpression="custPhone" />
                <asp:BoundField DataField="custAddress" HeaderText="Address" SortExpression="custAddress" />
                <asp:BoundField DataField="custCity" HeaderText="City" SortExpression="custCity" />
                <asp:BoundField DataField="custPostal" HeaderText="Postal Code" SortExpression="custPostal" />
                <asp:BoundField DataField="custEmail" HeaderText="Email" SortExpression="custEmail" />
                <asp:BoundField DataField="custName" HeaderText="custName" ReadOnly="True" SortExpression="custName" />
            </Columns>

<HeaderStyle CssClass="header" Font-Bold="False"></HeaderStyle>

<RowStyle CssClass="rows" HorizontalAlign="Center"></RowStyle>
        </asp:GridView>
    </p>
    
    <asp:ObjectDataSource ID="cityDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.CitiesTableAdapter"></asp:ObjectDataSource>
    
    
    <asp:ObjectDataSource ID="CustomerDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.CustomerTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="custFirst" Type="String" />
            <asp:Parameter Name="custLast" Type="String" />
            <asp:Parameter Name="custPhone" Type="String" />
            <asp:Parameter Name="custAddress" Type="String" />
            <asp:Parameter Name="custCity" Type="String" />
            <asp:Parameter Name="custPostal" Type="String" />
            <asp:Parameter Name="custEmail" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtCustomerSearch" ConvertEmptyStringToNull="False" DefaultValue="" Name="Param1" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="ddlCustomerCity" Name="Param2" PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="False" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="custFirst" Type="String" />
            <asp:Parameter Name="custLast" Type="String" />
            <asp:Parameter Name="custPhone" Type="String" />
            <asp:Parameter Name="custAddress" Type="String" />
            <asp:Parameter Name="custCity" Type="String" />
            <asp:Parameter Name="custPostal" Type="String" />
            <asp:Parameter Name="custEmail" Type="String" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>