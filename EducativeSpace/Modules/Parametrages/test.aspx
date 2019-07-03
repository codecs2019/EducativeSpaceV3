<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="Modules_Parametrages_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style6 {
            width: 8px;
        }
        .auto-style7 {
            height: 6px;
        }
        .auto-style8 {
            width: 236px;
        }
        .templateTable
        {
            border-collapse: collapse;
            width: 100%;
        }
        .templateTable td
        {
            border: solid 1px #C2D4DA;
            padding: 6px;
        }
        .templateTable td.value
        {
            font-weight: bold; 
        }
        .imageCell 
        {
            width: 160px;
        }
    </style>
    <style type="text/css">
        .name {
            font-weight: bold;
            padding-top: 5px;
            padding-left: 10px;
        }
        .photo {
            width: 84px;
            height: 84px;
            vertical-align: middle;
        }
        .frame {
            border: 1px solid lightgray;
            padding: 4px;
        }
        .description {
            color: gray;
            padding-top: 1px;
            padding-left: 10px;
        }
        .contactInfo {
            padding-bottom: 11px;
        }
        .selectedItem .description,
        .hoveredItem .description {
            color: inherit; /* The description section's text color is taken from the applied theme's selected and hovered styles. */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           <table class="templateTable">
                        <tr>
                            <td>
                                Journal des Ventes :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel1" runat="server"  />
                            </td>
                            <td>
                                Journal des Achats :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server"  />
                            </td>
                            <td>
                                Journal A Nouveau :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel3" runat="server"   />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Règlement Ventes :
                            </td>
                            <td class="value" colspan="2">
                                <dx:ASPxLabel ID="ASPxLabel4" runat="server"  />
                            </td>
                            <td>
                                Règlement Achats :
                            </td>
                            <td class="value" colspan="2">
                                <dx:ASPxLabel ID="ASPxLabel5" runat="server"  />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Vente 1 
                            </td>
                            <td colspan="3">
                                Glossaire Achat 1
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Vente 2 
                            </td>
                            <td colspan="3">
                                Glossaire Achat 2 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel9" runat="server" />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Stocks 1 
                            </td>
                            <td colspan="3">
                                Glossaire Projet 1 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel11" runat="server" />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Stocks 2 
                            </td>
                            <td colspan="3">
                                Glossaire Projet 2 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="lblNotes" runat="server" />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" />
                            </td>
                        </tr>
                    </table>
        </div>
    </form>
</body>
</html>
