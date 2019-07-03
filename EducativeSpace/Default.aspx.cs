using SoroZieApp.Models;
using System;
using System.IO;
using System.Web;

namespace SoroZieApp
{
    public partial class Default : System.Web.UI.Page
    {
        static ApplicationUser user; 
        protected void Page_Load(object sender, EventArgs e)
        {
            user = HttpContext.Current.Session["User"] as ApplicationUser;

            TextContent.InnerHtml = user == null ? File.ReadAllText(Server.MapPath(@"~/App_Data/OverviewDisplay.html")): File.ReadAllText(Server.MapPath(@"~/App_Data/OverviewDisplayAfter.html"));

            //TableOfContentsTreeView.DataBind();
            //TableOfContentsTreeView.ExpandAll();

            //ASPxImage1.ImageUrl = user == null ? "~/Content/Images/PageAccueilAvantConnexion.png" : "~/Content/Images/PageAccueilApresConnexion.png";
        }
    }
}