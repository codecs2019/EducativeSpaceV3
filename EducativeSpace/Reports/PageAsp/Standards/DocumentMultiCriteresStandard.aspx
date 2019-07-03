<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentMultiCriteresStandard.aspx.cs" Inherits="Reports_Comptabilité_Comptabilité_Analytique_BalanceAnalytique" %>

<%@ Register Assembly="DevExpress.XtraReports.v18.2.Web.WebForms, Version=18.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" DisableHttpHandlerValidation="False" Style="margin-top: 14px">
                <SettingsTabPanel Position="Left" />
                <ClientSideEvents Init="function(s, e) {
                        if(!s.GetPreviewModel().parametersModel.isEmpty()) {
                            s.GetPreviewModel().tabPanel.collapsed(false);
                            s.GetPreviewModel().tabPanel.tabs[0].active(true); 
                        }            
                }
" />
            </dx:ASPxWebDocumentViewer>

        </div>
    </form>
</body>
</html>
