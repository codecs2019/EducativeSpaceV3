using EducativeSpace.Models;
using System;
using System.Collections;
using System.Web.Security;

namespace SoroZieApp
{
    public partial class RegisterModule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            // DXCOMMENT: Your Registration logic
            //MembershipUser u = Membership.GetUser(User.Identity.Name);
            //MembershipUser u = Membership.CreateUser(login, "educative");

            try
            {
                if (Cl_Fonction.Verification_Code("aspnet_Users", "UserName", RegisterUserNameTextBox.Text))
                {
                    RegisterUserNameTextBox.ValidationSettings.ErrorDisplayMode = DevExpress.Web.ErrorDisplayMode.ImageWithText;
                    RegisterUserNameTextBox.ValidationSettings.ErrorText = "Ce username est déjà utilisé";
                }
                else
                {
                    if (Cl_Fonction.IsValidEmail(EmailTextBox.Text.Trim()))
                    {
                        ArrayList cle = new ArrayList();
                        ArrayList val = new ArrayList();

                        //string activationCode = Guid.NewGuid().ToString();
                        cle.Add("@CODE_PERSONNE"); val.Add(MatriculeTextBox.Text.Trim());
                        cle.Add("@NOM_PERSONNE"); val.Add(LastNameTextBox.Text.Trim());
                        cle.Add("@PRENOMS_PERSONNE"); val.Add(FirstNameTextBox.Text.Trim());
                        cle.Add("@USERNAME"); val.Add(RegisterUserNameTextBox.Text.Trim());
                        cle.Add("@SITE_ID"); val.Add(1);
                        cle.Add("@CONFIRMA"); val.Add("");
                        //cle.Add("@ACTIVATIONCODE");val.Add(activationCode);
                        cle.Add("@EMAIL"); val.Add(EmailTextBox.Text.Trim());
                        cle.Add("@SENDER"); val.Add(2);

                        Cl_Fonction.Extraction_ds("PS_USERCONFIRM", cle, val);

                        MembershipUser u = Membership.CreateUser(RegisterUserNameTextBox.Text.Trim(), ConfirmPasswordButtonEdit.Text, EmailTextBox.Text.Trim());

                        //SendActivationEmail(activationCode, txtEmail.Text.Trim());

                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Enregistrement effectué avec succès! Veuillez consulter l'administrateur pour accéder à la solution');", true);

                        Response.Redirect("~/");
                    }
                    else
                    {
                        EmailTextBox.ValidationSettings.ErrorText = "Veuillez SVP saisir une adresse mail valide";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Echec de l'enregistrement !');", true);
            }

        }
    }
}