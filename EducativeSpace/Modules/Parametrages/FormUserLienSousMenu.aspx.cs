﻿using DevExpress.Web;
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
    public partial class FormUserLienSousMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MainGridView.SettingsText.PopupEditFormCaption = "Affectation des profils aux utlisateurs";
        }

        //protected void cmbLogin_Load(object sender, EventArgs e)
        //{
        //    DataSet ds = new DataSet();
        //    ArrayList cle = new ArrayList();
        //    ArrayList vale = new ArrayList();
        //    cle.Add("@SITE_ID");
        //    vale.Add("");
        //    cle.Add("@SENDER");
        //    vale.Add(3);

        //    ds = Cl_Fonction.Extraction_ds("PS_E_UserLIENSOUSMENU", cle, vale);
        //    ASPxComboBox comboBox = (ASPxComboBox)sender;
        //    comboBox.DataSource = ds;
        //    comboBox.DataBind();
       //}
    }
}