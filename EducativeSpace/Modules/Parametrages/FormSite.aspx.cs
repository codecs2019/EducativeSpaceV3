using DevExpress.Web;
using System;
using System.Collections;
using System.IO;
using System.Web.UI.WebControls;
using EducativeSpace.Models;
using JfrSystems.Models;

public partial class Modules_Parametrages_FormSite : System.Web.UI.Page
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
        val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

        var emplacements = Cl_Fonction.Extraction_ds("PS_SITE", cle, val);
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
            val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

            cle.Add("@ADRESSE");
            val.Add(Cl_Fonction.GetStringTxt("adr", GridView, "pgControl"));

            cle.Add("@ADR_COMP");
            val.Add(Cl_Fonction.GetStringTxt("adrcom" , GridView , "pgControl"));

            cle.Add("@POST");
            val.Add(Cl_Fonction.GetStringTxt("pos",GridView, "pgControl"));

            cle.Add("@TEL1");
            val.Add(Cl_Fonction.GetStringTxt("tel1",GridView, "pgControl"));

            cle.Add("@TEL2");
            val.Add(Cl_Fonction.GetStringTxt("tel2",GridView, "pgControl"));

            cle.Add("@TEL3");
            val.Add(Cl_Fonction.GetStringTxt("tel3",GridView, "pgControl"));

            cle.Add("@CEL1");
            val.Add(Cl_Fonction.GetStringTxt("cel1",GridView, "pgControl"));

            cle.Add("@CEL2");
            val.Add(Cl_Fonction.GetStringTxt("cel2",GridView, "pgControl"));

            cle.Add("@CEL3");
            val.Add(Cl_Fonction.GetStringTxt("cel3",GridView, "pgControl"));

            cle.Add("@REG");
            val.Add(Cl_Fonction.GetStringTxt("reg",GridView, "pgControl"));

            cle.Add("@CMPT_CON");
            val.Add(Cl_Fonction.GetStringTxt("cmpt_con",GridView, "pgControl"));

            cle.Add("@STA");
            val.Add(Cl_Fonction.GetIntCmb("sta",GridView, "pgControl"));

            cle.Add("@RAI");
            val.Add(Cl_Fonction.GetStringTxt("rai",GridView, "pgControl"));

            cle.Add("@ACT");
            val.Add(Cl_Fonction.GetStringTxt("act",GridView, "pgControl"));

            cle.Add("@REGI");
            val.Add(Cl_Fonction.GetIntCmb("regi",GridView, "pgControl"));

            //cle.Add("@EFF");
            //val.Add(Cl_Fonction.GetStringTxt("eff",GridView, "pgControl"));

            cle.Add("@CNPS");
            val.Add(Cl_Fonction.GetStringTxt("cnps",GridView, "pgControl"));

            cle.Add("@CON1");
            val.Add( Cl_Fonction.GetIntCmb("con1",GridView, "pgControl"));
            cle.Add("@CON2");
            val.Add(Cl_Fonction.GetIntCmb("con2",GridView, "pgControl"));

            cle.Add("@CON3");
            val.Add(Cl_Fonction.GetIntCmb("con3",GridView, "pgControl"));
            /*
            cle.Add("@LOG");
            val.Add(Cl_Fonction.GetStringTxt("log",GridView, "pgControl"));

            cle.Add("@IMG");
            val.Add(Cl_Fonction.GetStringTxt("img",GridView, "pgControl"));
            */
            cle.Add("@DES");
            val.Add(Cl_Fonction.GetMemo("des",GridView, "pgControl"));

            cle.Add("@BAN");
            val.Add(Cl_Fonction.GetStringTxt("ban",GridView, "pgControl"));

            cle.Add("@CODBAN");
            val.Add(Cl_Fonction.GetStringTxt("codban",GridView, "pgControl"));

            cle.Add("@CODGUI");
            val.Add(Cl_Fonction.GetStringTxt("codgui",GridView, "pgControl"));

            cle.Add("@NUMBAN");
            val.Add(Cl_Fonction.GetStringTxt("ncmpt",GridView, "pgControl"));

            cle.Add("@CLE_RIB");
            val.Add(Cl_Fonction.GetStringTxt("rib",GridView, "pgControl"));

            cle.Add("@IBAN");
            val.Add(Cl_Fonction.GetStringTxt("iban",GridView, "pgControl"));

            cle.Add("@EMAIL1");
            val.Add(Cl_Fonction.GetStringTxt("ema1",GridView, "pgControl"));

            cle.Add("@EMAIL2");
            val.Add(Cl_Fonction.GetStringTxt("ema2",GridView, "pgControl"));

            cle.Add("@LOG");
            val.Add(Session["logo"]);

            cle.Add("@WEB");
            val.Add(Cl_Fonction.GetStringTxt("web",GridView, "pgControl"));

            Cl_Fonction.Execute_Commande_StoreProc("PS_SITE", cle, val);
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
        string index = GridView.GetRowValues(inde, "SITE_ID").ToString();
        try
        {
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@INDEX");
            val.Add("1");

            cle.Add("@ID");
            val.Add(AuthHelper.GetLoggedInUserInfo().SiteID.ToString());

            cle.Add("@ADRESSE");
            val.Add(Cl_Fonction.GetStringTxt("adr", GridView, "pgControl"));

            cle.Add("@ADR_COMP");
            val.Add(Cl_Fonction.GetStringTxt("adrcom", GridView, "pgControl"));

            cle.Add("@POST");
            val.Add(Cl_Fonction.GetStringTxt("pos", GridView, "pgControl"));

            cle.Add("@TEL1");
            val.Add(Cl_Fonction.GetStringTxt("tel1", GridView, "pgControl"));

            cle.Add("@TEL2");
            val.Add(Cl_Fonction.GetStringTxt("tel2", GridView, "pgControl"));

            cle.Add("@TEL3");
            val.Add(Cl_Fonction.GetStringTxt("tel3", GridView, "pgControl"));

            cle.Add("@CEL1");
            val.Add(Cl_Fonction.GetStringTxt("cel1", GridView, "pgControl"));

            cle.Add("@CEL2");
            val.Add(Cl_Fonction.GetStringTxt("cel2", GridView, "pgControl"));

            cle.Add("@CEL3");
            val.Add(Cl_Fonction.GetStringTxt("cel3", GridView, "pgControl"));

            cle.Add("@REG");
            val.Add(Cl_Fonction.GetStringTxt("reg", GridView, "pgControl"));

            cle.Add("@CMPT_CON");
            val.Add(Cl_Fonction.GetStringTxt("cmpt_con", GridView, "pgControl"));

            cle.Add("@STA");
            val.Add(Cl_Fonction.GetIntCmb("sta", GridView, "pgControl"));

            cle.Add("@RAI");
            val.Add(Cl_Fonction.GetStringTxt("rai", GridView, "pgControl"));

            cle.Add("@ACT");
            val.Add(Cl_Fonction.GetStringTxt("act", GridView, "pgControl"));

            cle.Add("@REGI");
            val.Add(Cl_Fonction.GetIntCmb("regi", GridView, "pgControl"));

            //cle.Add("@EFF");
            //val.Add(Cl_Fonction.GetStringTxt("eff",GridView, "pgControl"));

            cle.Add("@CNPS");
            val.Add(Cl_Fonction.GetStringTxt("cnps", GridView, "pgControl"));

            cle.Add("@CON1");
            val.Add(Cl_Fonction.GetIntCmb("con1", GridView, "pgControl"));
            cle.Add("@CON2");
            val.Add(Cl_Fonction.GetIntCmb("con2", GridView, "pgControl"));

            cle.Add("@CON3");
            val.Add(Cl_Fonction.GetIntCmb("con3", GridView, "pgControl"));
            /*
            cle.Add("@LOG");
            val.Add(Cl_Fonction.GetStringTxt("log",GridView, "pgControl"));

            cle.Add("@IMG");
            val.Add(Cl_Fonction.GetStringTxt("img",GridView, "pgControl"));
            */
            cle.Add("@DES");
            val.Add(Cl_Fonction.GetMemo("des", GridView, "pgControl"));

            cle.Add("@BAN");
            val.Add(Cl_Fonction.GetStringTxt("ban", GridView, "pgControl"));

            cle.Add("@CODBAN");
            val.Add(Cl_Fonction.GetStringTxt("codban", GridView, "pgControl"));

            cle.Add("@CODGUI");
            val.Add(Cl_Fonction.GetStringTxt("codgui", GridView, "pgControl"));

            cle.Add("@NUMBAN");
            val.Add(Cl_Fonction.GetStringTxt("ncmpt", GridView, "pgControl"));

            cle.Add("@CLE_RIB");
            val.Add(Cl_Fonction.GetStringTxt("rib", GridView, "pgControl"));

            cle.Add("@IBAN");
            val.Add(Cl_Fonction.GetStringTxt("iban", GridView, "pgControl"));

            cle.Add("@EMAIL1");
            val.Add(Cl_Fonction.GetStringTxt("ema1", GridView, "pgControl"));

            cle.Add("@EMAIL2");
            val.Add(Cl_Fonction.GetStringTxt("ema2", GridView, "pgControl"));


            cle.Add("@LOG");
            val.Add(Session["logo"]);

            cle.Add("@WEB");
            val.Add(Cl_Fonction.GetStringTxt("web", GridView, "pgControl"));

            Cl_Fonction.Execute_Commande_StoreProc("PS_SITE", cle, val);
            e.Cancel = true;
            GridView.CancelEdit();
            chargerGrid();
        }
        catch (Exception ex)
        {

        }
    }

    const string UploadDirectory = "~/Document/";

    protected void UploadControl_FilesUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        try
        {
            string result = "";
            UploadedFile file = e.UploadedFile;

            if (!string.IsNullOrEmpty(file.FileName) && file.IsValid)
            {
                //byte[] picbyte = file;
                string resultExtension = Path.GetExtension(file.FileName);
                string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                string resultFileUrl = UploadDirectory + resultFileName;
                string resultFilePath = MapPath(resultFileUrl);
                file.SaveAs(resultFilePath);
                string name = file.FileName;
                string url = ResolveClientUrl(resultFileUrl);
                long sizeInKilobytes = file.ContentLength / 1024;
                string sizeText = sizeInKilobytes.ToString() + " KB";
                Session["logo"] = file;
                result = resultFileUrl;
            }
            e.CallbackData = result;
        }
        catch (Exception ex)
        {

        }

    }
}