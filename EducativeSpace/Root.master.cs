using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using DevExpress.Web;
using System.Collections;
using System.Data;
using System.Web;
using ErpMasterSuite.Models;
using SoroZieApp.Models;

namespace SoroZieApp
{
    public partial class Root : MasterPage
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public bool EnableBackButton { get; set; }
        static ApplicationUser user;
        protected void Page_Load(object sender, EventArgs e)
        {
           user = HttpContext.Current.Session["User"] as ApplicationUser;
            if (!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";
            Page.Header.Title = Page.Header.Title + "eMasterSuite ERP";
            Page.Header.DataBind();
            UpdateUserMenuItemsVisible();
            HideUnusedContent();
            UpdateUserInfo();
        }

        protected void HideUnusedContent()
        {
            LeftAreaMenu.Items[1].Visible = EnableBackButton;
            bool hasLeftPanelContent = user != null ? true : false;
            LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
            LeftPanel.Visible = hasLeftPanelContent;

            bool hasRightPanelContent = user != null ? true : false;
            RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
            RightPanel.Visible = hasRightPanelContent;

            PageToolbarPanel.Visible = true;
        }


        // SignIn/Register

        protected void UpdateUserMenuItemsVisible()
        {
            var isAuthenticated = AuthHelper.IsAuthenticated();
            RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
            RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
            RightAreaMenu.Items.FindByName("ModifierItem").Visible = isAuthenticated;
            RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
            RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
        }

        protected void UpdateUserInfo()
        {
            if (AuthHelper.IsAuthenticated())
            {
                var user = AuthHelper.GetLoggedInUserInfo();
                var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
                var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
                var email = (ASPxLabel)myAccountItem.FindControl("EmailLabel");
                var accountImage = (HtmlGenericControl)RightAreaMenu.Items[0].FindControl("AccountImage");
                userName.Text = string.Format("{0} ({1} {2})", user.UserName, user.FirstName, user.LastName);
                email.Text = user.Email;
                accountImage.Attributes["class"] = "account-image";

                if (string.IsNullOrEmpty(user.AvatarUrl))
                {
                    accountImage.InnerHtml = string.Format("{0}{1}", user.FirstName[0], user.LastName[0]).ToUpper();
                }
                else
                {
                    var avatarUrl = (HtmlImage)myAccountItem.FindControl("AvatarUrl");
                    avatarUrl.Attributes["src"] = ResolveUrl(user.AvatarUrl);
                    accountImage.Style["background-image"] = ResolveUrl(user.AvatarUrl);
                }
            }
        }

        protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            if (e.Item.Name == "SignOutItem")
            {
                AuthHelper.SignOut(); // DXCOMMENT: Your Signing out logic

                if (Session["ConectMou"] == "1")
                {
                    ArrayList cle7 = new ArrayList();
                    ArrayList val7 = new ArrayList();

                    cle7.Add("@UNIQUE");
                    val7.Add(Session["ConectUnique"].ToString());

                    Cl_Fonction.Execute_Commande_StoreProc("MAJ_PROFILCONNECTFIN", cle7, val7);
                    Session["ConectMou"] = null;
                }

                Response.Redirect("~/");
            }
        }

        protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e)
        {
            e.Item.Image.Url = string.Format("Content/Images/{0}.svg", e.Item.Text);
            e.Item.Image.UrlSelected = string.Format("Content/Images/{0}-white.svg", e.Item.Text);
        }

        protected void ApplicationMenu_Load(object sender, EventArgs e)
        {
            try
            {
                if (user != null && ApplicationMenu.Items.Count == 0)
                {
                    DataTable dt = new DataTable();
                    ArrayList cle = new ArrayList();
                    ArrayList val = new ArrayList();
                    cle.Add("@LOGIN"); val.Add(user.UserName);
                    cle.Add("@SENDER"); val.Add(2);
                    dt = Cl_Fonction.Extraction_ds("PS_E_LIENSOUSMENU", cle, val, ref dt);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        MenuItem menuItem = new MenuItem();
                        menuItem.Name = dt.Rows[i]["ID_MENU"].ToString();
                        menuItem.Text = dt.Rows[i]["LIBELLE_MENU"].ToString();
                        menuItem.Image.IconID = dt.Rows[i]["ICONE"].ToString();
                        ApplicationMenu.Items.Add(menuItem);
                    }
                }
                if (user == null && ApplicationMenu.Items.Count != 0)
                {
                    HttpContext.Current.Response.RedirectLocation = System.Web.VirtualPathUtility.ToAbsolute("~/Account/SignIn.aspx");
                }

            }
            catch (Exception ex)
            {
                log.Info("Error : " + ex + "; Method : " + Cl_Fonction.GetCurrentMethod());
            }
        }
        protected void LeftCallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            try
            {
                if (user != null)
                {
                    DataTable dt = new DataTable();
                    ArrayList cle = new ArrayList();
                    ArrayList val = new ArrayList();
                    cle.Add("@LOGIN"); val.Add(user.UserName);
                    cle.Add("@ID_MENU"); val.Add(e.Parameter);
                    cle.Add("@SENDER"); val.Add(3);
                    dt = Cl_Fonction.Extraction_ds("PS_E_LIENSOUSMENU", cle, val, ref dt);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        string Libelle = dt.Rows[i]["LIBELLE_SOUSMENU"].ToString();
                        string id_sous_menu = dt.Rows[i]["ID_SOUSMENU"].ToString();

                        NavBarGroup nbg = new NavBarGroup();
                        nbg.Text = Libelle;
                        navbarMain.Groups.Add(nbg);

                        ////**************Lien************************//
                        DataTable dtlien = new DataTable();
                        ArrayList clelien = new ArrayList();
                        ArrayList vallien = new ArrayList();
                        clelien.Add("@LOGIN"); vallien.Add(user.UserName);
                        clelien.Add("@ID_SOUSMENU"); vallien.Add(Convert.ToInt32(id_sous_menu));
                        clelien.Add("@SENDER"); vallien.Add(1);
                        dtlien = Cl_Fonction.Extraction_ds("PS_E_LIENSOUSMENU", clelien, vallien, ref dtlien);

                        for (int ilien = 0; ilien < dtlien.Rows.Count; ilien++)
                        {

                            string LibelleLien = dtlien.Rows[ilien]["LIBELLE_LIENSOUSMENU"].ToString();
                            string idLien = dtlien.Rows[ilien]["ID_LIENSOUSMENU"].ToString();
                            string Chemin = dtlien.Rows[ilien]["CHEMIN"].ToString();
                            string Icone = dtlien.Rows[ilien]["ICONE"].ToString();

                            string Libellestatut = dtlien.Rows[ilien]["STATUT"].ToString();
                            string ID_TYPEDOCUMENT = dtlien.Rows[ilien]["ID_LIENSOUSMENU"].ToString();

                            string affichermontant = dtlien.Rows[ilien]["AFFICHER_MONTANT"].ToString();
                            string accederdate = dtlien.Rows[ilien]["ACCEDER_DATE"].ToString();

                            //DataTable dtlienstatut = new DataTable();
                            //ArrayList clelienstatut = new ArrayList();
                            //ArrayList vallienstatut = new ArrayList();
                            //clelienstatut.Add("@LIEN_SOUSMENU");
                            //vallienstatut.Add(idLien);
                            //clelienstatut.Add("@USERNAME");
                            //vallienstatut.Add(user.UserName);
                            //dtlienstatut = Cl_Fonction.Extraction_ds("PS_STATUT_USER", clelienstatut, vallienstatut, ref dtlienstatut);

                            //string ID_TYPEDOCUMENT = dtlienstatut.Rows[0]["ID_TYPEDOCUMENT"].ToString();

                            navbarMain.Groups.FindByText(Libelle.Trim()).Items.Add(LibelleLien.Trim()).Name = Chemin + "|" + Libellestatut + "|" + ID_TYPEDOCUMENT + "|" + idLien + "|" + affichermontant + "|" + accederdate;
                            navbarMain.Groups.FindByText(Libelle.Trim()).Items.FindByText(LibelleLien.Trim()).Image.Url = Icone.Trim();
                        }
                        //**************Fin Lien*******************//
                    }
                }
                else
                {
                    HttpContext.Current.Response.RedirectLocation = System.Web.VirtualPathUtility.ToAbsolute("~/Account/SignIn.aspx");
                }
            }
            catch (Exception ex)
            {
                log.Info("Error : " + ex + "; Method : " + Cl_Fonction.GetCurrentMethod());
            }
        }

        protected void ASPxCallbackPage_Callback(object sender, CallbackEventArgsBase e)
        {
            if (e.Parameter == "")
            {
                PageContent.Controls.Clear();
            }
            else
            {
                if (user != null)
                {
                    PageContent.Controls.Clear();
                    string menu = e.Parameter.ToString().Split('|')[0];
                    string statut = e.Parameter.ToString().Split('|')[1];
                    string idtypdoc = e.Parameter.ToString().Split('|')[2];
                    string idLien = e.Parameter.ToString().Split('|')[3];

                    string affichermontant = e.Parameter.ToString().Split('|')[4];
                    string accederdate = e.Parameter.ToString().Split('|')[5];

                    DataTable dt = new DataTable();
                    dt = Cl_Fonction.getLinkDetail(idLien, user.Rolename);

                    Session["DROIT"] = dt.Rows[0]["DROIT"].ToString();
                    Session["JOURNAUX"] = dt.Rows[0]["JOURNAUX"].ToString();
                    Session["TIERS"] = dt.Rows[0]["TIERS"].ToString();
                    Session["TYPEDOCUMENT"] = dt.Rows[0]["TYPEDOCUMENT"].ToString();
                    Session["ID_LIENSOUSMENU"] = idLien;
                    Session["STATUT_TYPEDOC"] = statut;
                    Session["ID_TYPEDOCUMENT "] = idtypdoc;

                    Session["AFFICHER_MONTANT"] = affichermontant;
                    Session["ACCEDER_DATE "] = accederdate;

                    string link = "<iframe src=\"" + menu + "\" scrolling='yes' frameborder='0' style='border:none; overflow:hidden; width:100%; height:1000px;' allowTransparency='true'></%iframe><br />";
                    PageContent.Controls.Add(new LiteralControl(link));
                }
                else
                    HttpContext.Current.Response.RedirectLocation = System.Web.VirtualPathUtility.ToAbsolute("~/Account/SignIn.aspx");
            }

        }
    }
}