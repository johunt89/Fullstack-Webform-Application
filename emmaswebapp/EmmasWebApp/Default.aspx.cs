using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace EmmasWebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                
                Response.Redirect("~/Login.aspx");
            }
            HtmlAnchor logout = (HtmlAnchor)this.Master.FindControl("login");
            logout.InnerText = "Logout";
            logout.ServerClick += new System.EventHandler(this.logout_Click);
        }
        void logout_Click(Object sender, EventArgs e)
        {
            Request.GetOwinContext().Authentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
    }
}