using DevExpress.Web;
using ErpMasterSuite.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoroZieApp.Modules.Parametrages
{
    public partial class FormProfilLien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MainGridView.SettingsText.PopupEditFormCaption = "Gestion des liens par profil";
            LoadGridView();
        }

        private void LoadGridView()
        {
            DataSet ds = new DataSet();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@ApplicationName"); val.Add("/");

            ds = Cl_Fonction.Extraction_ds("aspnet_Roles_GetAllRoles", cle, val);
            MainGridView.DataSource = ds;
            MainGridView.DataBind();

        }

        protected void MainGridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxTextBox RoleName = (ASPxTextBox)MainGridView.FindEditRowCellTemplateControl((GridViewDataColumn)MainGridView.Columns[1], "txtProfil");
            string rolename = RoleName.Text.Trim();
            if (!Roles.RoleExists(rolename))
                Roles.CreateRole(rolename);

            e.Cancel = true;
            MainGridView.CancelEdit();
            LoadGridView();

        }

        protected void MainGridView_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string selectedIds = MainGridView.GetSelectedFieldValues("RoleName")[0].ToString();

            Roles.DeleteRole(selectedIds, false);

            e.Cancel = true;

            LoadGridView();

        }

        protected void GridPage_DataSelect(object sender, EventArgs e)
        {
            Session["ID_ROLE"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void UserProfileDataSource_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            int visibleindex = MainGridView.FocusedRowIndex ;
            ASPxGridView sousgrid = MainGridView.FindDetailRowTemplateControl(visibleindex, "ThemeGridSite") as ASPxGridView;
            ASPxCheckBoxList listTiers = sousgrid.FindEditFormTemplateControl("chkListTiers") as ASPxCheckBoxList;
            string ListTiers = "";
            foreach (string val in listTiers.SelectedValues)
            {
                ListTiers += val+";";
            }

            ASPxCheckBoxList listJour= sousgrid.FindEditFormTemplateControl("chkListJourn") as ASPxCheckBoxList;
            string ListJour = "";
            foreach (string val in listJour.SelectedValues)
            {
                ListJour += val + ";";
            }

            ASPxCheckBoxList listaffichmontant = sousgrid.FindEditFormTemplateControl("ASPxCheckAfficherMontant") as ASPxCheckBoxList;
            string affichmontant = "0";
            foreach (string val in listaffichmontant.SelectedValues)
            {
                affichmontant = val ;
            }

            ASPxCheckBoxList listaccederdate = sousgrid.FindEditFormTemplateControl("ASPxCheckAccederDate") as ASPxCheckBoxList;
            string accederdate = "0";
            foreach (string val in listaccederdate.SelectedValues)
            {
                accederdate = val;
            }

            //ASPxCheckBoxList listDoc = sousgrid.FindEditFormTemplateControl("chkListDoc") as ASPxCheckBoxList;
            //string ListDoc = "";
            //foreach (string val in listDoc.SelectedValues)
            //{
            //    ListDoc += val + ";";
            //}

            e.Command.Parameters[2].Value = ListJour;
            e.Command.Parameters[3].Value = ListTiers;

            e.Command.Parameters[5].Value = affichmontant;
            e.Command.Parameters[6].Value = accederdate;
            //e.Command.Parameters[4].Value = ListDoc;
        }
    }
}