using System;
using DevExpress.Web;
using System.Data;
using System.Collections;
using System.Web;
using EducativeSpace.Models;
using JfrSystems.Models;

public partial class Web_FormTypeDocProfil : System.Web.UI.Page
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

        cle.Add("@SENDER");
        val.Add(0);
        

        ds = Cl_Fonction.Extraction_ds("PS_AFFECTATION_TYPEDOC_PROFILE", cle, val);
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

            cle.Add("@ID_AFFECT_ROLE");
            val.Add(code);

            cle.Add("@SENDER");
            val.Add(3);

            Cl_Fonction.Execute_Commande_StoreProc("PS_AFFECTATION_ROLE_TYPEDOC", cle, val);

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

    //AJOUTER

    protected void Enregistrer(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        string idrole = Cl_Fonction.GetstringCmb("cmbrole", MainGridView);
        int idtypedoc = Cl_Fonction.GetIntCmb("cmbtypedoc", MainGridView);
        int statut = Cl_Fonction.GetIntCmb("cmbStatut", MainGridView);
        
       
        try
        {
            // on vérifie si les différents champs obligatoires ne sont pas vide
            if ((idrole.ToString() != "") && (idtypedoc.ToString() != "") && (statut.ToString() != ""))
            {
                ArrayList cle = new ArrayList();
                ArrayList val = new ArrayList();

                cle.Add("@ID_ROLE");
                val.Add(idrole);

                cle.Add("@ID_TYPEDOC");
                val.Add(idtypedoc);

                cle.Add("@STATUT");
                val.Add(statut);

                cle.Add("@SENDER");
                val.Add(1);

                cle.Add("@ID_AFFECT_ROLE");
                val.Add(0);
                

                Cl_Fonction.Execute_Commande_StoreProc("PS_AFFECTATION_ROLE_TYPEDOC", cle, val);

                string code_message = message.CodeMessage.SUCCES.ToString();
                string lib_message = Cl_Fonction.message_defini(code_message);
                MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;

                e.Cancel = true;
                MainGridView.CancelEdit();
                chargerGrid();

            }
            else
            {
                e.Cancel = true;

                string code_message = message.CodeMessage.ECHEC.ToString();
                string lib_message = Cl_Fonction.message_defini(code_message);
                MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;
            }

        }
        catch (Exception ex)
        {
            e.Cancel = true;

            string code_message = message.CodeMessage.UNEXPECTED_ERROR.ToString();
            string lib_message = Cl_Fonction.message_defini(code_message);
            MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;
        }
    }

    //MODIFIER
    protected void Modifier(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        
        int index = Convert.ToInt32(MainGridView.FocusedRowIndex.ToString());
        string idrole_affect = MainGridView.GetRowValues(index, "ID_TYPEDOC_PROFIL").ToString();

        string idrole = Cl_Fonction.GetstringCmb("cmbrole", MainGridView);
        int idtypedoc = Cl_Fonction.GetIntCmb("cmbtypedoc", MainGridView);
        int statut = Cl_Fonction.GetIntCmb("cmbStatut", MainGridView);

        try
        {
            // on vérifie si les différents champs obligatoires ne sont pas vide
            if ((idrole.ToString() != "") && (idtypedoc.ToString() != "") && (statut.ToString() != ""))
            {
                ArrayList cle = new ArrayList();
                ArrayList val = new ArrayList();

                cle.Add("@ID_ROLE");
                val.Add(idrole);

                cle.Add("@ID_TYPEDOC");
                val.Add(idtypedoc);

                cle.Add("@STATUT");
                val.Add(statut);

                cle.Add("@SENDER");
                val.Add(2);

                cle.Add("@ID_AFFECT_ROLE");
                val.Add(idrole_affect);


                Cl_Fonction.Execute_Commande_StoreProc("PS_AFFECTATION_ROLE_TYPEDOC", cle, val);

                string code_message = message.CodeMessage.UPDATE_SUCCES.ToString();
                string lib_message = Cl_Fonction.message_defini(code_message);
                MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;

                e.Cancel = true;
                MainGridView.CancelEdit();
                chargerGrid();

            }
            else
            {
                e.Cancel = true;

                string code_message = message.CodeMessage.ECHEC.ToString();
                string lib_message = Cl_Fonction.message_defini(code_message);
                MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;
            }

        }
        catch (Exception ex)
        {
            e.Cancel = true;

            string code_message = message.CodeMessage.UNEXPECTED_ERROR.ToString();
            string lib_message = Cl_Fonction.message_defini(code_message);
            MainGridView.JSProperties["cpShowPopup"] = code_message + "|" + lib_message;
        }
    }

    
}

