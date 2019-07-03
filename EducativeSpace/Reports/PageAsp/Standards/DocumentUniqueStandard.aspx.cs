using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Etat_ETSSORO;
using RapportseMasterSuite;
using SoroZieApp.Models;

public partial class Reports_PageAsp_Gestion_Commerciale_Achats_BonDeCommandeAchat : System.Web.UI.Page
{
    static ApplicationUser user;
    protected void Page_Load(object sender, EventArgs e)
    {
        user = HttpContext.Current.Session["User"] as ApplicationUser;

        string typedocument= Session["TypeDocument"].ToString();
        string iddocument = Session["DocumentID"].ToString();

        /*if (typedocument == "21")
        {
            Constats report = new Etat_ETSSORO.Constats();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "29")
        {
            prevision_en_materiel_poue_travaux report = new Etat_ETSSORO.prevision_en_materiel_poue_travaux();
            report.Parameters["DocumentID"].Value = iddocument;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "24")
        {
            PrevisionEnCarburant report = new RapportseMasterSuite.PrevisionEnCarburant();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };


         if (typedocument == "25")
         {
            PersonnelEtMasseSalariales report = new RapportseMasterSuite.PersonnelEtMasseSalariales();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["Site_ID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };

        if (typedocument == "26")
        {
            valoristion_des_quantites_a_execute report = new Etat_ETSSORO.valoristion_des_quantites_a_execute();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "27")
        {
            prevision_autres_charges report = new Etat_ETSSORO.prevision_autres_charges();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        /*if (typedocument == "29")
        {
            Rapportdestravaux report = new Etat_ETSSORO.Rapportdestravaux();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "49")
        {
            Mouvement_entree report = new Etat_ETSSORO.Mouvement_entree();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "50")
        {
            MouvementdeSortie report = new Etat_ETSSORO.MouvementdeSortie();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "51")
        {
            VirementDepot_Depot report = new Etat_ETSSORO.VirementDepot_Depot();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "52")
        {
            VirementDepot_Depot report = new Etat_ETSSORO.VirementDepot_Depot();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "77")
        {
            sasie_inventaire report = new Etat_ETSSORO.sasie_inventaire();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "81")
         {
             DemandeEntretien report = new RapportseMasterSuite.DemandeEntretien();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };

        /*if (typedocument == "94")
        {
            NotificationsBudgetaires report = new Etat_ETSSORO.NotificationsBudgetaires();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        /*if (typedocument == "95")
        {
            Engagements report = new Etat_ETSSORO.Engagements();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "96")
        {
            OffreCandidatures report = new RapportseMasterSuite.OffreCandidatures();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        /* if (typedocument == "99")
         {
             Missions report = new Etat_ETSSORO.Missions();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

         if (typedocument == "100")
         {
             RapportDeMission report = new RapportseMasterSuite.RapportDeMission();
             report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["Site_ID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };

        /* if (typedocument == "101")
         {
             AffectationAuxMissions report = new Etat_ETSSORO.AffectationAuxMissions();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

        /* if (typedocument == "103")
         {
             CongesPersonnel report = new Etat_ETSSORO.CongesPersonnel();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

        /* if (typedocument == "104")
         {
             AbsencesDuPersonnel report = new Etat_ETSSORO.AbsencesDuPersonnel();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

        /*if (typedocument == "109")
        {
            AffectationAuxPostes report = new Etat_ETSSORO.AffectationAuxPostes();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "110")
        {
            FichePersonnelle report = new Etat_ETSSORO.FichePersonnelle();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        /*if (typedocument == "111")
        {
            FichesEnfants report = new Etat_ETSSORO.FichesEnfants();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        /*if (typedocument == "112")
        {
            PersonnelEnfantsACharge report = new Etat_ETSSORO.PersonnelEnfantsACharge();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "118")
        {
            FicheEntretien report = new RapportseMasterSuite.FicheEntretien();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        /*if (typedocument == "119")
            {
                GestionDesChantiers report = new Etat_ETSSORO.GestionDesChantiers();
                report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
                report.Parameters["SiteID"].Value = user.SiteID;
                report.CreateDocument();
                ASPxWebDocumentViewer1.OpenReport(report);
            };*/

        /*if (typedocument == "123")
        {
            FicheVehiculesEngins report = new Etat_ETSSORO.FicheVehiculesEngins();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        /* if (typedocument == "124")
         {
             AffectationDesVehiculesEngins report = new Etat_ETSSORO.AffectationDesVehiculesEngins();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

        if (typedocument == "160")
        {
            DossierAppelOffresFinanciere report = new RapportseMasterSuite.DossierAppelOffresFinanciere();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        /*if (typedocument == "141")
        {
            GestionDescourriers report = new Etat_ETSSORO.GestionDescourriers();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        /* if (typedocument == "22")
         {
             CreationDeBudget report = new Etat_ETSSORO.CreationDeBudget();
             report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
             report.Parameters["SiteID"].Value = user.SiteID;
             report.CreateDocument();
             ASPxWebDocumentViewer1.OpenReport(report);
         };*/

        /*if (typedocument == "28")
        {
            CreationDeRapport report = new Etat_ETSSORO.CreationDeRapport();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };*/

        if (typedocument == "151")
        {
            DevisFournisseur report = new Etat_ETSSORO.DevisFournisseur();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "152")
        {
            Achat_Bondecommande report = new Etat_ETSSORO.Achat_Bondecommande();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "153")
        {
            Achat_Bondelivraison report = new Etat_ETSSORO.Achat_Bondelivraison();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "150")
        {
            Achat_Facture report = new Etat_ETSSORO.Achat_Facture();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "156")
        {
            Devis report = new RapportseMasterSuite.Devis();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "157")
        {
            BonDeCommande report = new RapportseMasterSuite.BonDeCommande();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "158")
        {
            BonDeLivraison report = new RapportseMasterSuite.BonDeLivraison();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "159")
        {
            RapportseMasterSuite.Facture report = new RapportseMasterSuite.Facture();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

       

        if (typedocument == "239")
        {
            Achat_Besoinenmateriel report = new Etat_ETSSORO.Achat_Besoinenmateriel();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "240")
        {
            Achat_Besoinfinancie report = new Etat_ETSSORO.Achat_Besoinfinancie();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "46")
        {
            Achat_DemandeAchat report = new Etat_ETSSORO.Achat_DemandeAchat();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "163")
        {
            Attachements report = new RapportseMasterSuite.Attachements();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "234")
        {
            FicheDecompte report = new RapportseMasterSuite.FicheDecompte();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "79")
        {
            StatustiquesDesAchats report = new RapportseMasterSuite.StatustiquesDesAchats();
            report.Parameters["DocumentID;"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "78")
        {
            StatustiquesDesVentes report = new RapportseMasterSuite.StatustiquesDesVentes();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "80")
        {
            StatustiquesDesVentesParProjets report = new RapportseMasterSuite.StatustiquesDesVentesParProjets();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "238")
        {
            SortieCarburant report = new Etat_ETSSORO.SortieCarburant();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "241")
        {
            DemandeCarburant report = new Etat_ETSSORO.DemandeCarburant();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

         if (typedocument == "238")
        {
            SortieCarburant report = new Etat_ETSSORO.SortieCarburant();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "241")
        {
            DemandeCarburant report = new Etat_ETSSORO.DemandeCarburant();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "123")
        {
            FicheVehicules report = new Etat_ETSSORO.FicheVehicules();
            report.Parameters["Document_ID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["Site_ID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "267")
        {
            FactureRetour report = new RapportseMasterSuite.FactureRetour();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };

        if (typedocument == "268")
        {
            BonDeRetour report = new RapportseMasterSuite.BonDeRetour();
            report.Parameters["DocumentID"].Value = Session["DocumentID"].ToString(); ;
            report.Parameters["SiteID"].Value = user.SiteID;
            report.CreateDocument();
            ASPxWebDocumentViewer1.OpenReport(report);
        };
    }
}