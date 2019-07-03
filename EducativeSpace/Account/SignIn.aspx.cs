using System;
using DevExpress.Web;
using SoroZieApp.Models;
using System.Data;
using System.Collections;
using System.Web;
using ErpMasterSuite.Models;

namespace SoroZieApp
{
    public partial class SignInModule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            FormLayout.FindItemOrGroupByName("GeneralError").Visible = false;
            if (ASPxEdit.ValidateEditorsInContainer(this))
            {
                // DXCOMMENT: You Authentication logic
                if (AuthHelper.SignIn(UserNameTextBox.Text, PasswordButtonEdit.Text) == 0)
                {
                    ApplicationUser user = HttpContext.Current.Session["User"] as ApplicationUser;
                    int site_id = 0;
                    if (!string.IsNullOrEmpty(user.SiteID))
                        site_id = Convert.ToInt32(user.SiteID);

                    GestionConnexion(user.Rolename, 1, site_id);
                    Response.Redirect("~/");
                }
                else if (AuthHelper.SignIn(UserNameTextBox.Text, PasswordButtonEdit.Text) == 2)
                {
                    GeneralErrorDiv.InnerText = "Merci de vous rapprocher vous de votre administrateur pour acceder à la plateforme.";
                    FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;

                    GestionConnexion("", 0, 0);
                }
                else
                {
                    GeneralErrorDiv.InnerText = "Erreur d'authentification";
                    FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;

                    GestionConnexion("", 0, 0);

                }
            }
        }



        private void GestionConnexion(string roles, int sendmou, int site_id)
        {

            DataSet data7 = new DataSet();
            ArrayList cle7 = new ArrayList();
            ArrayList val7 = new ArrayList();

            cle7.Add("@LOGIN");
            val7.Add(UserNameTextBox.Text);

            cle7.Add("@ROLE");
            val7.Add(roles);

            string adres = HttpContext.Current.Request.UserHostAddress;
            cle7.Add("@ADRESSEID");
            val7.Add(adres);

            string nomnavig = HttpContext.Current.Request.UserAgent;
            cle7.Add("@NAVIGATEUR");
            val7.Add(nomnavig);

            string nommachine = HttpContext.Current.Request.UserHostName;
            cle7.Add("@NOMMACHINE");
            val7.Add(nommachine);

            cle7.Add("@EXO");
            val7.Add(0);

            cle7.Add("@SITE_ID");
            val7.Add(site_id);

            cle7.Add("@SENDER");
            val7.Add(sendmou);

            data7 = Cl_Fonction.Extraction_ds("MAJ_PROFILCONNECT", cle7, val7);
            Session["ConectUnique"] = data7.Tables[0].Rows[0].ItemArray[0].ToString();
            Session["ConectMou"] = "1";
        }

    }
}