
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EducativeSpace.Models;
using JfrSystems.Models;

public partial class Modules_Parametrages_FormParamComptable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        chargerGrid();
    }

    protected void chargerGrid()
    {
        ArrayList cle = new ArrayList();
        ArrayList val = new ArrayList();

        cle.Add("@INDEX");
        val.Add("3");
        cle.Add("@SITE_ID");
        val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

        var emplacements = Cl_Fonction.Extraction_ds("PS_PARAMCOMPTABLE", cle, val);
        GridView.DataSource = emplacements;
        GridView.DataBind();
    }

    protected void Enregistrer(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {

        try
        {
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@INDEX");
            val.Add("1");

            cle.Add("@ID");
            val.Add(0);

            cle.Add("@SITE_ID");
            val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

            cle.Add("@JACH");
            val.Add(Cl_Fonction.GetIntCmb("jach", GridView, "pgControl"));

            cle.Add("@JVEN");
            val.Add(Cl_Fonction.GetIntCmb("jven", GridView, "pgControl"));

            cle.Add("@JNOU");
            val.Add(Cl_Fonction.GetIntCmb("jnou", GridView, "pgControl"));

            cle.Add("@RACH");
            val.Add(Cl_Fonction.GetIntCmb("rach", GridView, "pgControl"));

            cle.Add("@RVEN");
            val.Add(Cl_Fonction.GetIntCmb("rven", GridView, "pgControl"));

            cle.Add("@ACH1");
            val.Add(Cl_Fonction.GetStringMemo("ach1", GridView, "pgControl"));

            cle.Add("@VEN1");
            val.Add(Cl_Fonction.GetStringMemo("ven1", GridView, "pgControl"));

            cle.Add("@ACH2");
            val.Add(Cl_Fonction.GetStringMemo("ach2", GridView, "pgControl"));

            cle.Add("@VEN2");
            val.Add(Cl_Fonction.GetStringMemo("ven2", GridView, "pgControl"));

            cle.Add("@STO1");
            val.Add(Cl_Fonction.GetStringMemo("sto1", GridView, "pgControl"));

            cle.Add("@PRO1");
            val.Add(Cl_Fonction.GetStringMemo("pro1", GridView, "pgControl"));

            cle.Add("@STO2");
            val.Add(Cl_Fonction.GetStringMemo("sto2", GridView, "pgControl"));

            cle.Add("@PRO2");
            val.Add(Cl_Fonction.GetStringMemo("pro2", GridView, "pgControl"));

            cle.Add("@PRE");
            val.Add(Cl_Fonction.GetStringMemo("pre", GridView, "pgControl"));

            Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMCOMPTABLE", cle, val);
            //e.Cancel = true;
            GridView.CancelEdit();
            chargerGrid();
        }
        catch (Exception ex)
        {

        }
    }

    protected void Modifier(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        int inde = Convert.ToInt32(GridView.FocusedRowIndex.ToString());
        string index = GridView.GetRowValues(inde, "ID").ToString();
        try
        {
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@INDEX");
            val.Add("1");

            cle.Add("@ID");
            val.Add(index);

            cle.Add("@SITE_ID");
            val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

            cle.Add("@JACH");
            val.Add(Cl_Fonction.GetIntCmb("jach", GridView, "pgControl"));

            cle.Add("@JVEN");
            val.Add(Cl_Fonction.GetIntCmb("jven", GridView, "pgControl"));

            cle.Add("@JNOU");
            val.Add(Cl_Fonction.GetIntCmb("jnou", GridView, "pgControl"));

            cle.Add("@RACH");
            val.Add(Cl_Fonction.GetIntCmb("rach", GridView, "pgControl"));

            cle.Add("@RVEN");
            val.Add(Cl_Fonction.GetIntCmb("rven", GridView, "pgControl"));

            cle.Add("@ACH1");
            val.Add(Cl_Fonction.GetStringMemo("ach1", GridView, "pgControl"));

            cle.Add("@VEN1");
            val.Add(Cl_Fonction.GetStringMemo("ven1", GridView, "pgControl"));

            cle.Add("@ACH2");
            val.Add(Cl_Fonction.GetStringMemo("ach2", GridView, "pgControl"));

            cle.Add("@VEN2");
            val.Add(Cl_Fonction.GetStringMemo("ven2", GridView, "pgControl"));

            cle.Add("@STO1");
            val.Add(Cl_Fonction.GetStringMemo("sto1", GridView, "pgControl"));

            cle.Add("@PRO1");
            val.Add(Cl_Fonction.GetStringMemo("pro1", GridView, "pgControl"));

            cle.Add("@STO2");
            val.Add(Cl_Fonction.GetStringMemo("sto2", GridView, "pgControl"));

            cle.Add("@PRO2");
            val.Add(Cl_Fonction.GetStringMemo("pro2", GridView, "pgControl"));

            cle.Add("@PRE");
            val.Add(Cl_Fonction.GetStringMemo("pre", GridView, "pgControl"));

            Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMCOMPTABLE", cle, val);
            e.Cancel = true;
            GridView.CancelEdit();
            chargerGrid();
        }
        catch (Exception ex)
        {

        }
    }
}