<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="EmmasWebApp.Orders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>Filter:</h3>
    <div class="settings">

        <label>Customer Name</label>
        <asp:DropDownList ID="ddlCustomer0" runat="server" AutoPostBack="True" DataSourceID="CustomerNameDataSource" DataTextField="custFull" DataValueField="id" OnDataBound="DdlCustomerChanged" OnSelectedIndexChanged="ddlCustomer0_SelectedIndexChanged"></asp:DropDownList>

    </div>
    <p>&nbsp;</p>
        <div class="customerButtons">
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        <asp:Button ID="btnClearFilters" runat="server" Text="Clear" OnClick="btnClearFilters_Click" />
        <asp:Button ID="btnDisplayAdd" runat="server" Text="New" OnClick="btnDisplayAdd_Click" />
    </div>
        <br />
    <div runat="server" id="customerAddSection" class="newCustomer settings">
            <fieldset>
                <legend>Create New Order</legend>
                <label>Order #</label>
                <asp:TextBox ID="txtOrderNumber" runat="server" ></asp:TextBox>
                <label>Employee Name</label>
                <asp:DropDownList ID="ddlEmployeeOrder" runat="server"  DataSourceID="EmployeeDataSource" DataTextField="empFull" DataValueField="id" OnDataBound="DdlChanged" ></asp:DropDownList>
    
                <label>Customer Name</label>
                <asp:DropDownList ID="ddlCustomer" runat="server" DataSourceID="CustomerNameDataSource" DataTextField="custFull" DataValueField="id" OnDataBound="DdlCustomerChanged"></asp:DropDownList>
    
                <label>Product</label>
                <asp:DropDownList ID="ddlProduct" runat="server" DataSourceID="ProductDataSource" DataTextField="product" DataValueField="id" OnDataBound="DdlProductChanged" ></asp:DropDownList>

                <label>Quantity</label>
                <asp:TextBox ID="txtQuantityInput" runat="server"></asp:TextBox>

                <label>Payment Type</label>
                <asp:DropDownList ID="ddlNewPaymentType" runat="server" DataSourceID="PaymentDataSource" DataTextField="payType" DataValueField="id" OnDataBound="DdlPayTypeChanged"></asp:DropDownList>

                <label>Paid</label>
                <asp:CheckBox ID="ChkPaid" runat="server" DataValueField="id"/>
                <asp:Button ID="btnSubmitOrder" runat="server" OnClick="btnSubmitOrder_Click" Text="Submit" />
                <asp:Button ID="btnClearAddInputs" runat="server" Text="Cancel" OnClick="btnClearAddInputs_Click" />
            </fieldset>
        </div>
    <br />
    <div id="orderFilteredGV">
        <asp:GridView ID="gvAllOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="AllOrdersDataSource" OnSelectedIndexChanged="gvAllOrders_SelectedIndexChanged" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8" OnRowUpdated="gvAllOrders_RowUpdated">
            <Columns>
                <%-- Anything read only is because I believe it does not make sense to allow edits on --%>
                <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" SortExpression="id" />
                <asp:TemplateField HeaderText="Order Number" InsertVisible="False" SortExpression="ordNumber">
                    <EditItemTemplate>
                        <asp:Label ID="lblOrderEditAll" runat="server" Text='<%# Bind("ordNumber") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblOrderAll" runat="server" Text='<%# Bind("ordNumber") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ordDate" HeaderText="Date" SortExpression="ordDate" DataFormatString="{0:yyyy-MM-dd}"/>
                <asp:CheckBoxField DataField="ordPaid" HeaderText="Paid" SortExpression="ordPaid" />
                <asp:TemplateField HeaderText="Payment ID" InsertVisible="False" SortExpression="paymentID">
                    <EditItemTemplate>
                        <asp:Label ID="lblPaymentEdit" runat="server" Text='<%# Bind("paymentID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPaymentAll" runat="server" Text='<%# Bind("paymentID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Customer ID" InsertVisible="False" SortExpression="custID">
                    <EditItemTemplate>
                        <asp:Label ID="lblcustIDEditAll" runat="server" Text='<%# Bind("custID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCustIdAll" runat="server" Text='<%# Bind("custID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee ID" InsertVisible="False" SortExpression="empID">
                    <EditItemTemplate>
                        <asp:Label ID="TextBox2" runat="server" Text='<%# Bind("empID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("empID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
        </asp:GridView>
        <asp:GridView ID="gvFilteredOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="OrdersDataSource" OnSelectedIndexChanged="gvFilteredOrders_SelectedIndexChanged" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8" OnRowUpdated="gvFilteredOrders_RowUpdated">
            <Columns>
                <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" SortExpression="id" />
                <asp:TemplateField HeaderText="Order Number" InsertVisible="False" SortExpression="ordNumber">
                    <EditItemTemplate>
                        <asp:Label ID="lblOrderEditFilt" runat="server" Text='<%# Bind("ordNumber") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblOrderFilt" runat="server" Text='<%# Bind("ordNumber") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ordDate" HeaderText="Date" SortExpression="ordDate" DataFormatString="{0:yyyy-MM-dd}"/>
                <asp:CheckBoxField DataField="ordPaid" HeaderText="Paid" SortExpression="ordPaid" />
                <asp:TemplateField HeaderText="Payment ID" InsertVisible="False" SortExpression="paymentID">
                    <EditItemTemplate>
                        <asp:Label ID="lblPaymentFilt" runat="server" Text='<%# Bind("paymentID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPaymentFilt" runat="server" Text='<%# Bind("paymentID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Customer ID" InsertVisible="False" SortExpression="custID">
                    <EditItemTemplate>
                        <asp:Label ID="lblcustIDEditFilt" runat="server" Text='<%# Bind("custID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCustIdFilt" runat="server" Text='<%# Bind("custID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee ID" InsertVisible="False" SortExpression="empID">
                    <EditItemTemplate>
                        <asp:Label ID="lblEmpFiltEdit" runat="server" Text='<%# Bind("empID") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblEmptFilt" runat="server" Text='<%# Bind("empID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
        </asp:GridView>
        <br />
    </div>
        <asp:GridView ID="gvOrderDetails" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="OrderDetailsDataSource" cssclass="table" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowSorting="True" PageSize="8" Visible="False">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="orlPrice" HeaderText="Price" SortExpression="orlPrice" DataFormatString="{0:C}" />
                <asp:BoundField DataField="orlQuantity" HeaderText="Quantity" SortExpression="orlQuantity" />
                <asp:BoundField DataField="receiptID" HeaderText="Receipt ID" SortExpression="receiptID" />
                <asp:BoundField DataField="lineTotal" HeaderText="Line Total" ReadOnly="True" SortExpression="lineTotal" DataFormatString="{0:C}" />
                <asp:BoundField DataField="prodName" HeaderText="Product Name" SortExpression="prodName" />
            </Columns>
    </asp:GridView>
        <br />
        
        <asp:ObjectDataSource ID="EmployeeDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Update" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.EmployeeTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="empFirst" Type="String" />
                <asp:Parameter Name="empLast" Type="String" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="empFirst" Type="String" />
                <asp:Parameter Name="empLast" Type="String" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    
        <asp:ObjectDataSource ID="OrdersDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.CustomerOrdersAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ordNumber" Type="String" />
                <asp:Parameter Name="ordDate" Type="DateTime" />
                <asp:Parameter Name="ordPaid" Type="Boolean" />
                <asp:Parameter Name="paymentID" Type="Int32" />
                <asp:Parameter Name="custID" Type="Int32" />
                <asp:Parameter Name="empID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCustomer0" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ordNumber" Type="String" />
                <asp:Parameter Name="ordDate" Type="DateTime" />
                <asp:Parameter Name="ordPaid" Type="Boolean" />
                <asp:Parameter Name="paymentID" Type="Int32" />
                <asp:Parameter Name="custID" Type="Int32" />
                <asp:Parameter Name="empID" Type="Int32" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    
        <asp:ObjectDataSource ID="PaymentDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.paymentTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="payType" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="payType" Type="String" />
                <asp:Parameter Name="Original_id" Type="Int32" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    
        <asp:ObjectDataSource ID="CustomerNameDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.CustomerNameTableAdapter"></asp:ObjectDataSource>
    
        <asp:ObjectDataSource ID="ProductDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.ProductTableAdapter">
        </asp:ObjectDataSource>
    
    
    <asp:ObjectDataSource ID="AllOrdersDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.AllCustomerOrdersTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ordNumber" Type="String" />
            <asp:Parameter Name="ordDate" Type="DateTime" />
            <asp:Parameter Name="ordPaid" Type="Boolean" />
            <asp:Parameter Name="paymentID" Type="Int32" />
            <asp:Parameter Name="custID" Type="Int32" />
            <asp:Parameter Name="empID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ordNumber" Type="String" />
            <asp:Parameter Name="ordDate" Type="DateTime" />
            <asp:Parameter Name="ordPaid" Type="Boolean" />
            <asp:Parameter Name="paymentID" Type="Int32" />
            <asp:Parameter Name="custID" Type="Int32" />
            <asp:Parameter Name="empID" Type="Int32" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    
    <asp:ObjectDataSource ID="OrderDetailsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EmmasLibrary.EmmasDataSetTableAdapters.OrderDetailsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="Param1" SessionField="ORDERID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    
    </asp:Content>