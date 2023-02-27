using EmmasLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EmmasLibrary.EmmasDataSetTableAdapters;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;

namespace EmmasWebApp
{
    public partial class Inventory : System.Web.UI.Page
    {
        private static EmmasDataSet dsEmmas;
        protected void Page_Load(object sender, EventArgs e)
        {
            inventoryAddSection.Visible = false;

            //changes login/logout text and function
            HtmlAnchor logout = (HtmlAnchor)this.Master.FindControl("login");
            logout.InnerText = "Logout";
            logout.ServerClick += new System.EventHandler(this.logout_Click);
        }

        protected void DdlBrandChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select Brand", ""));
        }

        protected void btnDisplayAdd_Click(object sender, EventArgs e)
        {
            inventoryAddSection.Visible = true;
        }

        protected void btnAddInventory_Click(object sender, EventArgs e)
        {
            InventoryTableAdapter daInventory = new InventoryTableAdapter();
            ProductCRUDTableAdapter daProduct = new ProductCRUDTableAdapter();

            int rowIndex = gvInventory.Rows.Count;
            int productID = (Int32.Parse(gvInventory.Rows.Count.ToString())) + 1;

            string Name = txtproductName.Text;
            string Description = txtDescripInput.Text;
            string Brand = txtBrandInput.Text;  

            string quantity = txtQuantityInput.Text.ToString();
            string size = txtSizeInput.Text.ToString();
            string measure = txtMeasureInput.Text;
            string price = txtPriceInput.Text.ToString();
            int quantityInt = 0;
            decimal sizeDec = 0;
            decimal priceDec = 0;


            //regex for verification
            Regex quantityRegex = new Regex(@"[0-9]$");
            Regex sizeRegex = new Regex(@"[0-9]$");
            Regex priceRegex = new Regex(@"^(?!0*\.0+$)\d*(?:\.\d+)?$");

            //booleans to verify
            bool nameVerified = false;
            bool descriptionVerified = false;
            bool brandVerified = false;
            bool quantityVerified = false;
            bool sizeVerified = false;
            bool measureVerified = false;
            bool priceVerified = false;

            if (Name.Length <= 50)
            {
                nameVerified = true;
            }
            else
            {
                nameVerified = false;
            }
            if (Description.Length <= 100)
            {
                descriptionVerified = true;

            }
            else
            {
                descriptionVerified = false;
            }

            if (Brand.Length <= 50)
            {
                brandVerified = true;
            }
            else
            {
                brandVerified = false;
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

            if (sizeRegex.Matches(size).Count == 1)
            {
                sizeVerified = true;
                sizeDec = Decimal.Parse(size);
            }
            else
            {
                sizeVerified = false;
            }

            if (measure.Length <= 20)
            {
                measureVerified = true;
            }
            else
            {
                measureVerified = false;
            }
            if (priceRegex.Matches(price).Count == 1)
            {
                priceVerified = true;
                priceDec = Decimal.Parse(price);
            }
            else
            {
                priceVerified = false;
            }
            
            //verifies data and then does insert into tables
            if (nameVerified == true && descriptionVerified == true && brandVerified == true && quantityVerified == true && sizeVerified == true && measureVerified == true && priceVerified == true)
            {
                //inserts 
                daProduct.Insert(Name, Description, Brand);
                daInventory.Insert(quantityInt, sizeDec, measure, priceDec, productID);

                //alerts the customer that a new customer has been created
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Inventory Successfully Added" + "');", true);

                //decided to have the page reload to have new inventory information displayed immediately
                Response.Redirect("~/Inventory.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Inventory creation failed, please check your data and try again." + "');", true);
            }
        }

        protected void gvProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            //stores index and then stores value in session before displaying
            int index = gvProduct.SelectedIndex;
            Session["productID"] = gvProduct.DataKeys[index].Value.ToString();
            gvInventory.Visible = true;
        }

        protected void ddlBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvInventory.Visible = false;
        }

        void logout_Click(Object sender, EventArgs e)
        {
            Request.GetOwinContext().Authentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
    }
}