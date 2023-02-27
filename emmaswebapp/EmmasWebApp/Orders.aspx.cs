using EmmasLibrary;
using EmmasLibrary.EmmasDataSetTableAdapters;
using System;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace EmmasWebApp
{
    public partial class Orders : System.Web.UI.Page
    {
        private static EmmasDataSet dsEmmas;

        static Orders()
        {
            dsEmmas = new EmmasDataSet();

        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
            }
            //changes the text to display logout instead of login
            HtmlAnchor logout = (HtmlAnchor)this.Master.FindControl("login");
            logout.InnerText = "Logout";
            logout.ServerClick += new System.EventHandler(this.logout_Click);

            customerAddSection.Visible = false;

            //displaying the correct gridview based on selections
            if (ddlCustomer0.SelectedIndex == 0)
            {
                gvFilteredOrders.Visible = false;
                gvAllOrders.Visible = true;
            }
            if (!IsPostBack)
            {
                if (ddlCustomer0.SelectedIndex == 0)
                {
                    gvFilteredOrders.Visible = false;
                    gvAllOrders.Visible = true;
                }
                if (Session["id"] != null)
                {
                    ddlCustomer0.SelectedValue = Session["id"].ToString();
                    gvFilteredOrders.Visible = true;
                    gvAllOrders.Visible = false;
                }
            }
        }

        //changes visibility as needed
        protected void btnDisplayAdd_Click(object sender, EventArgs e)
        {
            customerAddSection.Visible = true;
            this.gvOrderDetails.Visible = false;
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            InventoryCRUDTableAdapter daInventory = new InventoryCRUDTableAdapter();
            CustomerOrdersAdapter daCustomerOrders = new CustomerOrdersAdapter();

            ////storing info into variables to make insert and update clean
            int id = Int32.Parse(ddlProduct.SelectedValue);
            string orderNumber = txtOrderNumber.Text.ToString();
            int employeeID = Int32.Parse(ddlEmployeeOrder.SelectedValue);
            int customerID = Int32.Parse(ddlCustomer.SelectedValue);
            string product = ddlProduct.Text;
            string quantity = (Int32.Parse(txtQuantityInput.Text) * -1).ToString(); //so that it subtracts the amount from inventory rather than adds
            DateTime date = DateTime.Now;
            int paymentType = Int32.Parse(ddlNewPaymentType.SelectedValue);
            bool paid = ChkPaid.Checked;
            int quantityInt = 0;

            //bools to use as a checker before insert

            bool orderVerified = false;
            bool employeeVerified = false;
            bool customerVerified = false;
            bool quantityVerified = false;
            bool paymentVerified = false;

            //regex to verify the inputs meet what it should , check length in if statements after regex
            Regex orderRegex = new Regex(@"[0-9]$");
            Regex quantityRegex = new Regex(@"[0-9]$");

            if (orderRegex.Matches(orderNumber).Count == 1 && orderNumber.Length <= 20)
            {
                orderVerified = true;
            }
            else
            {
                orderVerified = false;
            }
            if (ddlEmployeeOrder.SelectedIndex != 0)
            {
                employeeVerified = true;
            }
            else
            {
                employeeVerified = false;
            }

            if (ddlCustomer.SelectedIndex != 0)
            {
                customerVerified = true;
            }
            else
            {
                customerVerified = false;
            }

            if (quantityRegex.Matches(quantity).Count == 1)
            {
                quantityVerified = true;
                quantityInt = Int32.Parse(quantity);
            }
            else
            {
                quantityVerified = false;
            }

            if (ddlNewPaymentType.SelectedIndex != 0)
            {
                paymentVerified = true;
            }
            else
            {
                paymentVerified = false;
            }

            if (orderVerified == true && employeeVerified == true && customerVerified == true && paymentVerified == true && quantityVerified == true)
            {
                daCustomerOrders.Insert(orderNumber, date, paid, paymentType, customerID, employeeID);
                daInventory.Update(id, quantityInt);
                //Message for user to confirm submission
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Order Successfully Added" + "');", true);

                //new information display immediately as it refreshes the page
                ddlCustomer0.SelectedIndex = 0;
                gvAllOrders.Visible = true;
                this.gvOrderDetails.Visible = false;
                Response.Redirect("~/Orders.aspx");
                
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Order creation failed, please check your data and try again." + "');", true);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            if (ddlCustomer0.SelectedIndex == 0)
            {
                gvFilteredOrders.Visible = false;
                gvAllOrders.Visible = true;
                this.gvOrderDetails.Visible = false;
            }
            else
            {
                gvFilteredOrders.Visible = true;
                gvAllOrders.Visible = false;
                this.gvOrderDetails.Visible = false;
            }
        }

        protected void ddlCustomer0_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList ddl = (DropDownList)sender;
                ddl.Items.Insert(0, new ListItem("Select Customer", ""));
            }

            if (ddlCustomer0.SelectedIndex == 0)
            {
                gvFilteredOrders.Visible = false;
                gvAllOrders.Visible = true;
                this.gvOrderDetails.Visible = false;
            }
            else
            {
                gvFilteredOrders.Visible = true;
                gvAllOrders.Visible = false;
                this.gvOrderDetails.Visible = false;
            }
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            ddlCustomer0.SelectedIndex = 0;
            gvFilteredOrders.Visible = false;
            gvAllOrders.Visible = true;
            this.gvOrderDetails.Visible = false;
        }

        protected void gvAllOrders_SelectedIndexChanged(object sender, EventArgs e)
        {

            //stores order id in session, rebinds and displays details
            Session["ORDERID"] = gvAllOrders.SelectedRow.Cells[1].Text;
            OrderDetailsDataSource.DataBind();
            this.gvOrderDetails.Visible = true;
            gvOrderDetails.DataBind();
        }

        protected void gvFilteredOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            //stores order id in session, rebinds and displays details
            Session["ORDERID"] = gvFilteredOrders.SelectedRow.Cells[1].Text;
            OrderDetailsDataSource.DataBind();
            this.gvOrderDetails.Visible = true;
            gvOrderDetails.DataBind();
        }

        //error catching for order updates
        protected void gvAllOrders_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            //if (e.ExceptionHandled == false)
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "deleteAlert", "alert('" + "There was an error updating the record, please check your data and try again." + "');", true);
            //    e.ExceptionHandled = true;
            //}
        }
        protected void gvFilteredOrders_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

            //if (e.ExceptionHandled == false)
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "deleteAlert", "alert('" + "There was an error updating the record, please check your data and try again." + "');", true);
            //    e.ExceptionHandled = true;
            //}

        }
        protected void btnClearAddInputs_Click(object sender, EventArgs e)
        {
            txtOrderNumber.Text = "";
            ddlEmployeeOrder.SelectedIndex = -1;
            ddlCustomer.SelectedIndex = 0;
            ddlProduct.SelectedIndex = 0;
            txtQuantityInput.Text = "";
            ddlNewPaymentType.SelectedIndex = 0;
            ChkPaid.Checked = false;
        }

        //logs user out and returns to the login page
        void logout_Click(Object sender, EventArgs e)
        {
            Request.GetOwinContext().Authentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
        //lots of drop down default inserts
        protected void DdlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select Employee", ""));
        }

        protected void DdlCustomerChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select Customer", ""));
        }
        protected void DdlPayTypeChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select Payment Type", ""));
        }
        protected void DdlProductChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select Product", ""));
        }

        

        
    }
}