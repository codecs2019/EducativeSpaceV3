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

namespace EducativeSpace.Modules.Parametrages
{
    public partial class FormMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MainGridView.SettingsText.PopupEditFormCaption = "Gestion des menus";
        }

    }
}