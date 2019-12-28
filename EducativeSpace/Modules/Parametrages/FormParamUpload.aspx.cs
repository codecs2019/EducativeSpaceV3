using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EducativeSpace.Models;
using JfrSystems.Models;


public partial class Modules_Parametrages_FormParamUpload : System.Web.UI.Page
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
        cle.Add("@ID");
        val.Add("");

        var emplacements = Cl_Fonction.Extraction_ds("PS_PARAMETRE_UPLOAD", cle, val);
        GridView.DataSource = emplacements;
        GridView.DataBind();
    }

    protected void Nouveau(object sender, EventArgs e)
    {
        GridView.FocusedRowIndex = -1;
        GridView.AddNewRow();
    }

    protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        if (e.Parameters == "delete")
        {
            List<int> selectedIds = GridView.GetSelectedFieldValues("ID").ConvertAll(id => (int)id);
            foreach (int item in selectedIds)
            {
                try
                {
                    int code = (int)item;
                    ArrayList cle = new ArrayList();
                    ArrayList val = new ArrayList();

                    cle.Add("@INDEX");
                    val.Add("2");
                    cle.Add("@ID");
                    val.Add(code);

                    Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMETRE_UPLOAD", cle, val);
                    GridView.JSProperties["cpShowPopup"] = "Success";
                    //e.Cancel = true;

                    chargerGrid();
                }
                catch (Exception ex)
                {
                    //e.Cancel = true;
                    GridView.JSProperties["cpShowPopup"] = "Error";
                }
            }
            GridView.DataBind();
        }
    }

    //AJOUTER

    protected void Enregistrer(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        string libelle = Cl_Fonction.GetStringTxt("lib", GridView);
        string observation = Cl_Fonction.GetStringMemo("com", GridView);


        if (Cl_Fonction.Verification_Code("Daf.TYPE_RESSOURCES", "LIBELLE", libelle.ToLower()))
        {
            GridView.JSProperties["cpShowPopup"] = "Caution";
            e.Cancel = true;
        }
        else
        {
            try
            {
                ArrayList cle = new ArrayList();
                ArrayList val = new ArrayList();

                cle.Add("@INDEX");
                val.Add("1");

                cle.Add("@ID");
                val.Add("0");

                cle.Add("@COMMENTAIRE");
                val.Add(observation);

                cle.Add("@LIBELLE");
                val.Add(libelle);

                cle.Add("@DATE");
                val.Add(DateTime.Now);

                cle.Add("@USER");
                val.Add(AuthHelper.GetLoggedInUserInfo().UserName.ToString());

                Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMETRE_UPLOAD", cle, val);
                GridView.JSProperties["cpShowPopup"] = "Success";
                e.Cancel = true;
                GridView.CancelEdit();
                chargerGrid();

            }
            catch (Exception ex)
            {

                e.Cancel = true;

                GridView.JSProperties["cpShowPopup"] = "Error";


            }

        }
    }

    //MODIFIER
    protected void Modifier(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        // int index = Convert.ToInt32(GridView.FocusedRowIndex.ToString());
        var selectedIds = GridView.GetSelectedFieldValues("ID");
        string index = selectedIds[0].ToString();
        string libelle = Cl_Fonction.GetStringTxt("lib", GridView);
        string observation = Cl_Fonction.GetStringMemo("com", GridView);


        try
        {
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();


            cle.Add("@INDEX");
            val.Add("1");

            cle.Add("@ID");
            val.Add(index);

            cle.Add("@COMMENTAIRE");
            val.Add(observation);

            cle.Add("@LIBELLE");
            val.Add(libelle);

            cle.Add("@DATE");
            val.Add(DateTime.Now);

            cle.Add("@USER");
            val.Add(AuthHelper.GetLoggedInUserInfo().UserName.ToString());

            Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMETRE_UPLOAD", cle, val);
            GridView.JSProperties["cpShowPopup"] = "Success";
            e.Cancel = true;
            GridView.CancelEdit();
            chargerGrid();

        }
        catch (Exception ex)
        {

            e.Cancel = true;

            GridView.JSProperties["cpShowPopup"] = "Error";


        }
    }

    //SUPPRESSION
    protected void Delete(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        List<int> selectedIds = GridView.GetSelectedFieldValues("ID").ConvertAll(id => (int)id);
        foreach (int item in selectedIds)
        {
            int code = (int)item;
            try
            {
                //string code = e.Keys[0].ToString();
                ArrayList cle = new ArrayList();
                ArrayList val = new ArrayList();

                cle.Add("@ID"); val.Add(code);
                cle.Add("@INDEX"); val.Add(2);

                Cl_Fonction.Execute_Commande_StoreProc("PS_PARAMETRE_UPLOAD", cle, val);
                GridView.JSProperties["cpShowPopup"] = "Success";
                e.Cancel = true;

                chargerGrid();
            }
            catch (Exception Ex)
            {
                e.Cancel = true;
                GridView.JSProperties["cpShowPopup"] = "Error";
            }
        }
    }
}