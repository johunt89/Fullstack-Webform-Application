<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="EmmasWebApp.Inventory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <h3>Filters:</h3>
    <div class="settings">

        <label>Brand</label>
        <asp:DropDownList ID="ddlBrand" runat="server" AutoPostBack="True" DataSourceID="BrandDataSource" DataTextField="prodBrand" DataValueField="prodBrand" OnDataBound="DdlBrandChanged" Height="22px" Width="96px" OnSelectedIndexChanged="ddlBrand_SelectedIndexChanged"></asp:DropDownList>
        
    </div>
    <br />
    <div class="customerButtons">
        <asp:Button ID="btnSearch" runat="server" Text="Search" />
        <asp:Button ID="btnClearFilters" runat="server" Text="Clear" />
        <asp:Button ID="btnDisplayAdd" runat="server" Text="New" OnClick="btnDisplayAdd_Click" />
    </div>
    <p>
        &nbsp;</p>
        <div runat="server" id="inventoryAddSection" class="newCustomer settings">
        <fieldset>
            <legend>Add Inventory</legend>
            <label>Prdocut Name</label>
            <asp:TextBox ID="txtproductName" name="first" runat="server"></asp:TextBox>

            <label>Product Description</label>
            <asp:TextBox ID="txtDescripInput" runat="server"></asp:TextBox>
            
            <label>Brand</label>
            <asp:TextBox ID="txtBrandInput" runat="server"></asp:TextBox>

            <label>Quantity</label>
            <asp:TextBox ID="txtQuantityInput" runat="server"></asp:TextBox>

            <label>Size</label>
            <asp:TextBox ID="txtSizeInput" runat="server"></asp:TextBox>

            <label>Measure</label>
            <asp:TextBox ID="txtMeasureInput" runat="server"></asp:TextBox>

            <label>Price</label>
            <asp:TextBox ID="txtPriceInput" runat="server"></asp:TextBox>

            <asp:Button ID="btnAddInventory" runat="server" Text="Add" OnClick="btnAddInventory_Click" />
            <asp:Button ID="btnClearAddInputs" runat="server" Text="Cancel"/>

            
        </fieldset>
            
    </div>
        <br />
    <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ProductDataSource" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8" OnSelectedIndexChanged="gvProduct_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="prodName" HeaderText="Name" SortExpression="prodName" />
            <asp:BoundField DataField="prodDescription" HeaderText="Description" SortExpression="prodDescription" />
            <asp:BoundField DataField="prodBrand" HeaderText="Brand" SortExpression="prodBrand" />
        </Columns>

<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
    </asp:GridView>
        <br />
        <asp:GridView ID="gvInventory" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="InventoryDataSource" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="invQuantity" HeaderText="Quantity" SortExpression="invQuantity" />
                <asp:BoundField DataField="invSize" HeaderText="Size" SortExpression="invSize" />
                <asp:BoundField DataField="invMeasure" HeaderText="Measure" SortExpression="invMeasure" />
                <asp:BoundField DataField="invPrice" HeaderText="Price" SortExpression="invPrice" DataFormatString="{0:C2}" />
                <asp:BoundField DataField="productID" HeaderText="Product ID" SortExpression="productID" />
            </Columns>

<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
        </asp:GridView>
        <br />
        <asp:ObjectDataSource ID="InventoryDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.InventoryTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="invQuantity" Type="Int32" />
                <asp:Parameter Name="invSize" Type="Decimal" />
                <asp:Parameter Name="invMeasure" Type="String" />
                <asp:Parameter Name="invPrice" Type="Decimal" />
                <asp:Parameter Name="productID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="Param1" SessionField="productID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="invQuantity" Type="Int32" />
                <asp:Parameter Name="invSize" Type="Decimal" />
                <asp:Parameter Name="invMeasure" Type="String" />
                <asp:Parameter Name="invPrice" Type="Decimal"/>
                <asp:Parameter Name="productID" Type="Int32" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ProductDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.InventoryProductTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="prodName" Type="String" />
                <asp:Parameter Name="prodDescription" Type="String" />
                <asp:Parameter Name="prodBrand" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlBrand" Name="Param1" PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="False" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="prodName" Type="String" />
                <asp:Parameter Name="prodDescription" Type="String" />
                <asp:Parameter Name="prodBrand" Type="String" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </UpdateParameters>
    </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="BrandDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.BrandTableAdapter"></asp:ObjectDataSource>
    </div>
    
   
    
    
</asp:Content>