using System;
using System.Web.UI;
using System.Web;
using SoroZieApp.Models;

namespace SoroZieApp
{
    public partial class StartRoot : MasterPage
    {
        public bool EnableBackButton { get; set; }
        static ApplicationUser user;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";
            Page.Header.Title = Page.Header.Title + "eMasterSuite ERP";

            Page.Header.DataBind();
        }


        protected void Page_Init(object sender, EventArgs e)
        {
            //user = HttpContext.Current.Session["User"] as ApplicationUser;
            //if (user == null)
            //{
            //    //Soucis d'utilisation du javascript ici
            //    HttpContext.Current.Response.RedirectLocation = System.Web.VirtualPathUtility.ToAbsolute("~/Default2.aspx");            
            //}
            user = HttpContext.Current.Session["User"] as ApplicationUser;
            if (user == null)
            {
                Response.Redirect("~/");
            }
        }
    }
}