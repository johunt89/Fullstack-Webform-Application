using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EmmasLibrary;
using EmmasLibrary.EmmasDataSetTableAdapters;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using Microsoft.AspNet.Identity;

namespace EmmasWebApp
{
    
    public partial class Customers : System.Web.UI.Page
    {
        private static EmmasDataSet dsEmmas;
        static Customers()
        {
            dsEmmas = new EmmasDataSet();
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //verifies user is logged in, if not sends them to the login page
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
            }

            //changes the text to display logout instead of login
            HtmlAnchor logout = (HtmlAnchor)this.Master.FindControl("login");
            logout.InnerText = "Logout";
            logout.ServerClick += new System.EventHandler(this.logout_Click);

            //hides the add section on page load
            customerAddSection.Visible = false;

            //hides a column i did not want to display
            gvCustomerInfo.Columns[10].Visible = false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnDisplayAdd_Click(object sender, EventArgs e)
        {
            customerAddSection.Visible = true;
            lblErrorMessage.Visible = false;
        }

        protected void btnAddCustomer_Click(object sender, EventArgs e)
        {
            CustomerTableAdapter daCustomerInfo = new CustomerTableAdapter();

            lblErrorMessage.Text = "";
            //save text inputs to variables, didnt have to, just made the insert line cleaner and easier to read
            try
            {
                //variables to make code below a little cleaner

                string email = txtEmailInput.Text;
                string first = txtFirstInput.Text;
                string last = txtLastInput.Text;
                string address = txtAddressInput.Text;
                string city = txtCityInput.Text;
                string postal = txtPostInput.Text;
                string phone = txtPhoneInput.Text;

                //these are used to determine if all inputs are within paramaters before inserting to db

                bool emailVerified = false;
                bool firstVerified = false;
                bool lastVerified = false;
                bool addressVerified = false;
                bool cityVerified = false;
                bool postalVerified = false;
                bool phoneVerified = false;

                //regex to verify the inputs meet what it should , check length in if statements after regex
                Regex emailRegex = new Regex(@"^[a-zA-z0-9_-]+[@][a-zA-Z0-9.]+[.][a-zA-Z]+$");
                Regex firstRegex = new Regex(@"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$");
                Regex lastRegex = new Regex(@"^(?<firstchar>(?=[A-Za-z]))((?<alphachars>[A-Za-z])|(?<specialchars>[A-Za-z]['-](?=[A-Za-z]))|(?<spaces> (?=[A-Za-z])))*$");
                Regex addressRegex = new Regex(@"[A-Za-z0-9]+(?:\s[A-Za-z0-9'_-]+)+$");
                Regex cityRegex = new Regex(@"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$");
                //assuming Canadian customers only, no spaces or dashes
                Regex postalRegex = new Regex(@"^([ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ])\ {0,1}(\d[ABCEGHJKLMNPRSTVWXYZ]\d)$");
                //no spaces or dashes, numbers only
                Regex phoneRegex = new Regex(@"^[0-9]{10}$"); 

                //checks to see if there is a match to the regex, if there is
                //and if it meets the length requirements it returns a true boolean for later
                //else it returns an error message
                //i could have done this after each box but opted to do so at time of submission
                if (emailRegex.Matches(email).Count == 1  && email.Length <= 30)
                {
                    emailVerified = true;
                }
                else
                {
                    emailVerified = false;
                    lblErrorMessage.Text = "Email Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                if (firstRegex.Matches(first).Count == 1 && first.Length <= 30)
                {
                    firstVerified = true;

                }
                else
                {
                    firstVerified = false;
                    lblErrorMessage.Text += "First Name Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                if(lastRegex.Matches(last).Count == 1 && last.Length <= 50)
                {
                    lastVerified = true;
                }
                else
                {
                    lastVerified = false;

                    lblErrorMessage.Text += "Last Name Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }
                
                if(phoneRegex.Matches(phone).Count == 1 && phone.Length == 10)
                {
                    phoneVerified = true;
                }
                else
                {
                    phoneVerified = false;
                    lblErrorMessage.Text += "Phone Number Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                if(addressRegex.Matches(address).Count == 1 && address.Length <= 60)
                {
                    addressVerified = true;
                }
                else
                {
                    addressVerified = false;

                    lblErrorMessage.Text+= "Address Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                if(cityRegex.Matches(city).Count == 1 && city.Length <= 50)
                {
                    cityVerified = true;
                }
                else
                {
                    cityVerified = false;
                    lblErrorMessage.Text += "City Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                if (postalRegex.Matches(postal).Count == 1 && postal.Length == 6)
                {
                    postalVerified = true;
                }
                else
                {
                    postalVerified = false;
                    lblErrorMessage.Text += "Postal Code Error <br/>";
                    lblErrorMessage.Visible = true;
                    customerAddSection.Visible = true;
                }

                //verifies all fields have return a true, fi so it proceeds with the insert.
                //else throws an error alert
                if (emailVerified == true && firstVerified == true && lastVerified == true && phoneVerified == true && 
                    addressVerified == true && cityVerified == true && postalVerified == true && emailVerified == true)
                {
                    //inserting record
                    daCustomerInfo.Insert(first, last, phone, address, city, postal, email);

                    //alerts the customer that a new customer has been created
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Customer Successfully Added" + "');", true);
                    
                    //decided to have the page reload to have new customer information and new cities displayed immediately
                    //Could DataBind instead but decided to do it this way.
                    Response.Redirect("~/Customers.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "There was an error adding the customer. Please check your data and try again.  If the error persists contact your system administrator." + "');", true);
                }
                
            }
            catch 
            {
                
            }
        }

        protected void gvCustomerInfo_SelectedIndexChanged(object sender, EventArgs e)
        {

            //if selectedRow is not null a selection has been made, this gives the customer ID to pass to the order page
            if(gvCustomerInfo.SelectedRow != null)
            {
                int index = gvCustomerInfo.SelectedIndex;
                Session["id"] = gvCustomerInfo.DataKeys[index].Value.ToString();
                Response.Redirect("~/Orders.aspx");
            }
        }

        //to add a default value to the drop down list
        protected void DdlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            ddl.Items.Insert(0, new ListItem("Select City", ""));
        }

        //hide the error message and reset the textboxes to be blank on click
        protected void btnClearAddInputs_Click(object sender, EventArgs e)
        {
            
            lblErrorMessage.Visible = false;

            txtAddressInput.Text = "";
            txtCityInput.Text = "";
            txtEmailInput.Text = "";
            txtFirstInput.Text = "";
            txtLastInput.Text = "";
            txtPhoneInput.Text = "";
            txtPostInput.Text = "";
        }

        //logs the user out and returns them to the login page
        void logout_Click(Object sender, EventArgs e)
        {
            Request.GetOwinContext().Authentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }

        //reset the filters to display all results
        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            ddlCustomerCity.SelectedIndex = 0;
            txtCustomerSearch.Text = "";
        }

        //error catching if the customer has records
        protected void gvCustomerInfo_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ClientScript.RegisterStartupScript(this.GetType(), "deleteAlert", "alert('" + "Customer has records, you cannot delete this customer" + "');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "deleteAlert", "alert('" + "Customer record succesfully removed" + "');", true);
            }
        }

        //error catching record updates
        protected void gvCustomerInfo_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ClientScript.RegisterStartupScript(this.GetType(), "updateAlert", "alert('" + "Unable to update customer information.  Please verify the data you entered and try again." + "');", true);
            };
        }
    }
}