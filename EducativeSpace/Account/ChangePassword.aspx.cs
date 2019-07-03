using SoroZieApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_ChangePassword : System.Web.UI.Page
{
    static ApplicationUser user;
    protected void Page_Load(object sender, EventArgs e)
    {
        user = HttpContext.Current.Session["User"] as ApplicationUser;
    }

    protected void ValiderButton_Click(object sender, EventArgs e)
    {
        MembershipUser u = Membership.GetUser(user.UserName);

        try
        {
            if (ConfPasswordButtonEdit.Text == PasswordButtonEdit.Text)
            {
                if (u.ChangePassword(OldPasswordButtonEdit.Text, PasswordButtonEdit.Text))
                {
                    GeneralErrorDiv.InnerText = "Mot de passe mis à jour.";
                }
                else
                {
                    GeneralErrorDiv.InnerText = "Password change failed. Please re-enter your values and try again.";
                }
            }
            else
            {
                GeneralErrorDiv.InnerText = "Merci de confirmer votre nouveau mot de passe";
            }

        }
        catch (Exception ex)
        {
            GeneralErrorDiv.InnerText = "An exception occurred: " + Server.HtmlEncode(ex.Message) + ". Please re-enter your values and try again.";
        }
    }
}