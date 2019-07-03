using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Etat_ETSSORO;
using RapportseMasterSuite;
using EtateMasterSuite.Rapports;
using reporting.Reports;
using SoroZieApp.Models;

public partial class Reports_Comptabilité_Comptabilité_Analytique_BalanceAnalytique : System.Web.UI.Page
{
    static ApplicationUser user;
    protected void Page_Load(object sender, EventArgs e)
    {
        user = HttpContext.Current.Session["User"] as ApplicationUser;
        string typedocument = Session["ID_LIENSOUSMENU"].ToString();
        try
        {
            if (typedocument == "189")
            {
                BrouillardDeSaisie report = new BrouillardDeSaisie();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "190")
            {
                JournalCompte report = new JournalCompte();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "199")
            {
                JournalCenralise report = new JournalCenralise();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "200")
            {
                JournalGeneral report = new JournalGeneral();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "228")
            {
                GrandLivreComptes report = new GrandLivreComptes();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "201")
            {
                BalanceComptesGeneral report = new BalanceComptesGeneral();
                report.Parameters["SiteId"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "202")
            {
                BalanceComptesGeneral6Col report = new BalanceComptesGeneral6Col();
                report.Parameters["SiteId"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            /*else if (typedocument == "203")
             {
                 BalanceComptesGeneral8Col report = new BalanceComptesGeneral6Col();
                 report.Parameters["SiteID"].Value = user.SiteID;
                 report.CreateDocument();
                 ASPxWebDocumentViewer1.OpenReport(report);
             }*/

            else if (typedocument == "204")
            {
                ExtraitCompteGeneral report = new ExtraitCompteGeneral();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "205")
            {
                JustificatifDeSoldeGal report = new JustificatifDeSoldeGal();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "218")
            {
                GrandLivreAnalytiq report = new GrandLivreAnalytiq();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "217")
            {
                BalanceAnalytique report = new BalanceAnalytique();
                report.Parameters["SiteId "].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            /*else if (typedocument == "207")
             {
                 BalanceComptesTiers6Col report = new BalanceComptesTiers6Col();
                 report.Parameters["SiteID"].Value = user.SiteID;
                 report.CreateDocument();
                 ASPxWebDocumentViewer1.OpenReport(report);
             }*/

            /* else if (typedocument == "208")
             {
                 BalanceComptesGeneral8Col report = new BalanceComptesTiers8Col();
                 report.Parameters["SiteID"].Value = user.SiteID;
                 report.CreateDocument();
                 ASPxWebDocumentViewer1.OpenReport(report);
             }*/

            else if (typedocument == "209")
            {
                ExtraitCompteTiers report = new ExtraitCompteTiers();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "210")
            {
                JustificatifDeSoldeTiers report = new JustificatifDeSoldeTiers();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "216")
            {
                JournalAnalytique report = new JournalAnalytique();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }


            else if (typedocument == "206")
            {
                BalanceComptesTiers report = new BalanceComptesTiers();
                report.Parameters["SiteId"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "198")
            {
                GrandLivreTiers report = new GrandLivreTiers();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "213")
            {
                EtatdesImmobilisations report = new EtatdesImmobilisations();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "214")
            {
                EtatdesImmobilisations report = new EtatdesImmobilisations();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "215")
            {
                PlanAmortissementEconomique report = new PlanAmortissementEconomique();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "220")
            {
                ListePlanAnalytique report = new ListePlanAnalytique();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "221")
            {
                listeSection report = new listeSection();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }


            else if (typedocument == "222")
            {
                ListeDesComptes report = new ListeDesComptes();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "223")
            {
                ListeDesJournaux report = new ListeDesJournaux();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "76")
            {
                EtatInventaireADate report = new EtatInventaireADate();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "224")
            {
                listeTiers report = new listeTiers();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "225")
            {
                ListeDesBanques report = new ListeDesBanques();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "226")
            {
                listecontact report = new listecontact();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "263")
            {
                MvtStockDetails report = new MvtStockDetails();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

            else if (typedocument == "265")
            {
                EntreesEnStock report = new EntreesEnStock();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }
            else if (typedocument == "266")
            {
                SortiesDeStock report = new SortiesDeStock();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }


            else if (typedocument == "269")
            {
                SortiesDeStock_ListDocs report = new SortiesDeStock_ListDocs();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }
            else if (typedocument == "282")
            {
                ConsoCarburantVehicule report = new ConsoCarburantVehicule();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }
            else if (typedocument == "283")
            {
                MvtStockCarburant report = new MvtStockCarburant();
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            }

        }
        catch (Exception ex)
        {


        }
    }
}