using System;
using DevExpress.Web;
using System.Data;
using System.Collections;
using System.Web;
using EducativeSpace.Models;  
using JfrSystems.Models;

public partial class Web_FormJournalConnexion : System.Web.UI.Page
{
    static ApplicationUser user;
    protected void Page_Load(object sender, EventArgs e)
    {
        user = HttpContext.Current.Session["User"] as ApplicationUser;
        chargerGrid();  
    }

    protected void chargerGrid()
    {

        DataSet ds = new DataSet();
        ArrayList cle = new ArrayList();
        ArrayList val = new ArrayList();

        cle.Add("@Site_ID");
        val.Add(user.SiteID);
        

        ds = Cl_Fonction.Extraction_ds("LISTE_JOURNALCONNECT_SITE", cle, val);
        MainGridView.DataSource = ds;
        MainGridView.DataBind();
    }

    //SUPPRESSION
    protected void Delete(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        try
        {
            string code = e.Keys[0].ToString();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@Site_ID");
            val.Add(code);

            cle.Add("@SENDER");
            val.Add(3);

            Cl_Fonction.Execute_Commande_StoreProc("LISTE_JOURNALCONNECT_SITE", cle, val);

            string code_message = message.CodeMessage.DELETE_SUCCES.ToString();
            string lib_message = Cl_Fonction.message_defini(code_message);
            MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;

            e.Cancel = true;

            chargerGrid();
        }
        catch (Exception ex)
        {
            e.Cancel = true;
            string code_message = message.CodeMessage.UNEXPECTED_ERROR.ToString();
            string lib_message = Cl_Fonction.message_defini(code_message);
            MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;
        }
    }

  

    protected void ASPxGridView2_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
    {
        if (e.RowType != GridViewRowType.Data) return;
        int statut = Convert.ToInt32(e.GetValue("STATUTCONNECT"));
        if (statut == 0)
            e.Row.ForeColor = System.Drawing.Color.Red;
        if (statut == 1)
            e.Row.ForeColor = System.Drawing.Color.Orange;
    }


}

