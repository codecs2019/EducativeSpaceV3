using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EducativeSpace.Models;
using JfrSystems.Models;

namespace EducativeSpaceApp.Modules.Parametrages
{
    public partial class FormLienSousMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) 
        {
            MainGridView.SettingsText.PopupEditFormCaption = "Gestion des liens par sous menu";
        }
    } 
}