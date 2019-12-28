using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EducativeSpace.Models;
using JfrSystems.Models;
using System.Web.Security;
using System.Web.Profile;

namespace EducativeSpaceApp.Modules.Parametrages
{
    public partial class FormSousMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MainGridView.SettingsText.PopupEditFormCaption = "Gestion des sous menus";
        }

        protected void chargerGrid()
        {
            DataSet ds = new DataSet();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@SENDER");val.Add(0);

            Cl_Fonction.Extraction_ds("PS_E_SOUSMENU", cle, val);
            MainGridView.DataSource = ds;
            MainGridView.DataBind();

        }

        protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "delete")
            {
               
            }

            if (e.Parameters == "update")
            {
                
            }

            if (e.Parameters == "insert")
            {

            }
        }
    }
}