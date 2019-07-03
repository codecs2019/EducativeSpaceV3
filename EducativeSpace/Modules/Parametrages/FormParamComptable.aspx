<%@ Page Title="Type ressource" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true"  CodeFile="FormParamComptable.aspx.cs" Inherits="Modules_Parametrages_FormParamComptable" %>

<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
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
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <dx:ASPxMenu runat="server" ID="PageToolbar" ClientInstanceName="pageToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar">
        <ClientSideEvents ItemClick="onPageToolbarItemClick" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1>Paramètres comptables</h1>
                </Template>
            </dx:MenuItem>
        <dx:MenuItem Name="New" Text="Ajouter" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Editer" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/edit.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Supprimer" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/delete.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Export" Text="Exporter" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/export.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="ToggleFilterPanel" Text="" GroupName="Filter" Alignment="Right" AdaptivePriority="1">
                <Image Url="~/Content/Images/search.svg" UrlChecked="~/Content/Images/search-selected.svg" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
    <dx:ASPxPanel runat="server" ID="FilterPanel" ClientInstanceName="filterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Search" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="onFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView" OnRowUpdating="Modifier" OnRowInserting="Enregistrer" KeyFieldName="ID" EnablePagingGestures="False" CssClass="grid-view" Width="100%">
        <Toolbars>
                    <dx:GridViewToolbar>
                        <Items>
                            <dx:GridViewToolbarItem Command="ShowCustomizationWindow"  Text="Modifier la liste" Visible="false" />
                        </Items>
                    </dx:GridViewToolbar>
                </Toolbars>
        
        <SettingsLoadingPanel Mode="ShowOnStatusBar" />
        <SettingsBehavior EnableCustomizationWindow="true" />
        <ClientSideEvents EndCallback="function(s, e) {
                                        var es = s.cpShowPopup;
                                        if(es=='Success') { 
                                           MessageSuccessPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='Error') { 
                                            MessageErrorPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='Caution') { 
                                            MessageCautionPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='Droit') { 
                                            MessageAutorisationPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        }" />
        <Columns>
            <dx:GridViewDataColumn FieldName="ID"  />
            <dx:GridViewDataColumn FieldName="SITE_ID" Width="100%" />
        </Columns>

        <Templates>
            <DataRow>
                <div style="padding: 5px">
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
                                Glossaire Vente 1  :
                            </td>
                            <td colspan="3">
                                Glossaire Achat 1 :
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text='<%# Eval("GLOSSAIRE_VENTE_1") %>' />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text='<%# Eval("GLOSSAIRE_ACHAT_1") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Vente 2 :
                            </td>
                            <td colspan="3">
                                Glossaire Achat 2 :
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text='<%# Eval("GLOSSAIRE_VENTE_2") %>' />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text='<%# Eval("GLOSSAIRE_ACHAT_2") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Stocks 1 :
                            </td>
                            <td colspan="3">
                                Glossaire Projet 1 :
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text='<%# Eval("GLOSSAIRE_STOCK_1") %>' />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text='<%# Eval("GLOSSAIRE_CHANTIER_1") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                Glossaire Stocks 2 :
                            </td>
                            <td colspan="3">
                                Glossaire Projet 2 :
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="lblNotes" runat="server" Text='<%# Eval("GLOSSAIRE_STOCK_2") %>' />
                            </td>
                            <td colspan="3" style="vertical-align: top;">
                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text='<%# Eval("GLOSSAIRE_CHANTIER_2") %>' />
                            </td>
                        </tr>
                    </table>
                </div>
            </DataRow>
            <EditForm>
                <dx:ASPxPageControl runat="server" ID="pgControl" Width="100%" Border-BorderColor="White" Border-BorderWidth="0">
                            <TabPages>
                                 <dx:TabPage Text="Journaux">
                                     <ContentCollection>
                                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                 <table>
                <tr>
                    <td class="auto-style7"></td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Journal des Ventes :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="jven" ValueField="ID_JOURNAL" DataSourceID="JournalSource" Text='<%# Eval("JOURNAL_VENTE_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="CODE_JOURNAL" />
                                <dx:ListBoxColumn FieldName="INTITULE_JOURN" />
                            </Columns>
                        </dx:ASPxComboBox>
                    </td>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Règlements Ventes :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="rven" ValueField="ID_JOURNAL" DataSourceID="JournalSource" Text='<%# Eval("JR_REGLEMENT_VENTE_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="CODE_JOURNAL" />
                                <dx:ListBoxColumn FieldName="INTITULE_JOURN" />
                            </Columns>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7"></td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Journal des Achats :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="jach" ValueField="ID_JOURNAL" DataSourceID="JournalSource" Text='<%# Eval("JOURNAL_ACHAT_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="CODE_JOURNAL" />
                                <dx:ListBoxColumn FieldName="INTITULE_JOURN" />
                            </Columns>
                        </dx:ASPxComboBox>
                    </td>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Journal A Nouveau :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="jnou" ValueField="ID_JOURNAL" DataSourceID="JournalSource" Text='<%# Eval("JOURNAL_ANOUVEAU_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="CODE_JOURNAL" />
                                <dx:ListBoxColumn FieldName="INTITULE_JOURN" />
                            </Columns>
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7"></td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Règlement Achats :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="rach" ValueField="ID_JOURNAL" DataSourceID="JournalSource" Text='<%# Eval("JR_REGLEMENT_ACHAT_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="CODE_JOURNAL" />
                                <dx:ListBoxColumn FieldName="INTITULE_JOURN" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource runat="server" ID="JournalSource" ConnectionString='<%$ ConnectionStrings:MasterSuiteConnectionString %>' SelectCommand="SELECT * FROM Compta.JOURNAL"></asp:SqlDataSource>
                    </td>
                    <td class="auto-style6"></td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Règlement Achats :" />
                    </td>
                    <td colspan="5">
                        <dx:ASPxComboBox runat="server" ID="pre" ValueField="ID" DataSourceID="ProduitSource" Text='<%# Eval("PRESTATION_ID") %>'>
                            <Columns>
                                <dx:ListBoxColumn FieldName="LIBELLE" />
                            </Columns>
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource runat="server" ID="ProduitSource" ConnectionString='<%$ ConnectionStrings:MasterSuiteConnectionString %>' SelectCommand="SELECT * FROM Stock.PRODUITS"></asp:SqlDataSource>
                    </td>
                </tr>
                
                <tr>
                    <td>&nbsp;</td>
                </tr>
                
                </table>
                                    </dx:ContentControl>
                                    </ContentCollection>
                                 </dx:TabPage>
                           
                                 <dx:TabPage Text="Glossaires">
                                     <ContentCollection>
                                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                            <table>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Vente 1  :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="ven1" Text='<%# Eval("GLOSSAIRE_VENTE_1") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Achat 1  :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="ach1" Text='<%# Eval("GLOSSAIRE_ACHAT_1") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Vente 2  :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="ven2" Text='<%# Eval("GLOSSAIRE_VENTE_2") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Achat 2 :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="ach2" Text='<%# Eval("GLOSSAIRE_ACHAT_2") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Stock 1 :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="sto1" Text='<%# Eval("GLOSSAIRE_STOCK_1") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Projet 1 :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="pro1"  Text='<%# Eval("GLOSSAIRE_CHANTIER_1") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Stocks 2 :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="sto2"  Text='<%# Eval("GLOSSAIRE_STOCK_2") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Glossaire Projet 2 :" />
                                                    </td>
                                                    <td colspan="5">
                                                        <dx:ASPxMemo runat="server" Rows="7" Width="300px" ID="pro2"  Text='<%# Eval("GLOSSAIRE_CHANTIER_2") %>'/>
                                                    </td>
                                                </tr>
                                                    <tr>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                            </table>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                 </dx:TabPage>
                           </TabPages>
                        </dx:ASPxPageControl>
                &nbsp; &nbsp;
                        <center>
                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1" Text="Modifier"  ReplacementType="EditFormUpdateButton" runat="server">
                            </dx:ASPxGridViewTemplateReplacement>
                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement2" Text="Annuler" ReplacementType="EditFormCancelButton" runat="server">
                            </dx:ASPxGridViewTemplateReplacement>
                        </center>
                &nbsp; &nbsp;
                </EditForm>
        </Templates>
        <SettingsCommandButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image Url="~/Content/100x23/VALIDER.png">
                </Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image Url="~/Content/100x23/ANNULER.png">
                </Image>
            </CancelButton>
        </SettingsCommandButton>
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="true" />
                            <SettingsText ConfirmDelete="Voulez-Vous Supprimer ? " />
                            <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="2" />
                            <SettingsText  CommandCancel="ANNULER" CommandUpdate="VALIDER"  PopupEditFormCaption="Paramètres Comptables" />
                            <Settings ShowColumnHeaders="false" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto" />
                            <SettingsExport EnableClientSideExportAPI="true" ExportSelectedRowsOnly="true" />
                            <SettingsPopup>
                                <EditForm>
                                    <SettingsAdaptivity MaxWidth="855" Mode="Always" VerticalAlign="WindowTop" />
                                </EditForm>
                            </SettingsPopup>

        <Styles>
            <Cell Wrap="false" />
            <PagerBottomPanel CssClass="pager" />
            <FocusedRow CssClass="focused" />
        </Styles>
        <ClientSideEvents Init="onGridViewInit" SelectionChanged="onGridViewSelectionChanged" />
    </dx:ASPxGridView>
    

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True"
        CloseAction="CloseButton"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        EnableViewState="False" PopupElementID="popupArea" 
        ShowFooter="False" ShowOnPageLoad="False" Width="600px"
        Height="420px" FooterText=""
        HeaderText="Choix de l'étudiant" ClientInstanceName="ASPxPopupControl1" 
        EnableHierarchyRecreation="True" EnableClientSideAPI="True"
        CssPostfix="Aqua" EnableHotTrack="False"  
        Modal="True" style="margin-top: 44px">
        <LoadingPanelImage Url="~/App_Themes/Office2010Blue/Web/Loading.gif">
        </LoadingPanelImage>
        <LoadingPanelStyle ImageSpacing="5px">
        </LoadingPanelStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="False">
                
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents CloseUp ="function(s, e) {
                gridView.PerformCallback();
               }
        "/>
    </dx:ASPxPopupControl>

    <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" runat="server" ClientInstanceName="ASPxLoadingPanel1">
    </dx:ASPxLoadingPanel>


    <dx:ASPxPopupControl ID="ASPxInf" runat="server" ClientInstanceName="InfoPanel" 
        CloseAction="CloseButton" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        HeaderText="Fenêtre d'information" AllowDragging="True" 
        EnableAnimation="False" EnableViewState="False" Width="340px" 
        Height="102px" CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
        CssPostfix="Aqua" EnableHotTrack="False" 
        SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css" >

        <LoadingPanelImage Url="~/App_Themes/Office2010Blue/Web/Loading.gif">
        </LoadingPanelImage>
        <LoadingPanelStyle ImageSpacing="5px">
        </LoadingPanelStyle>

        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server">
                <dx:ASPxPanel ID="ASPxPanel2" runat="server" DefaultButton="btOK" Width="322px">
                    <PanelCollection>
                        <dx:PanelContent ID="PanelContent1" runat="server">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="4">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td rowspan="4">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption" valign="top">
                                        <dx:ASPxLabel ID="ASPxInfo" runat="server" ClientInstanceName="TxtInfo" 
                                            Text="ASPxLabel">
                                        </dx:ASPxLabel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td class="pcmCheckBox">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <table cellpadding="0" cellspacing="0" style="width: 110%; margin-left: 192px;">
                                                <tr>
                                                    <td align="right">
                                                        
                                                    </td>
                                                    <td>
                                                        <div style="width: 8px;">
                                                        </div>
                                                    </td>
                                                    <td align="left">
                                                        <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Ok" Width="80px" 
                                                            AutoPostBack="False" 
                                                            CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
                                                            CssPostfix="Office2010Blue" 
                                                            SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css" 
                                                            ClientInstanceName="ASPxButton5">
                                                            <ClientSideEvents Click="function(s, e) { InfoPanel.Hide(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        
    </dx:ASPxPopupControl>
    <!--PopUpcontrol Message SUCCESS-->
    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" ClientInstanceName="MessageSuccessPopupControl"
        CloseAction="None" Height="100px" Width="269px" PopupHorizontalAlign="WindowCenter"
         PopupVerticalAlign="TopSides"  EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
        CssPostfix="Aqua" Modal="true" ModalBackgroundStyle-BackColor="White"
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowCloseButton="False">
        <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
        </LoadingPanelImage>
        <ContentStyle VerticalAlign="Top">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <div>
                    <table align="center" cellpadding="10" cellspacing="0">
                        <tr>
                            <td>
                                <dx:ASPxImage ID="ASPxImage2" runat="server" ImageUrl="~/Images/icone_projet/documentinfo.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Opération effectuée avec succès !">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton11" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="ok"
                                    Width="50px" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) {MessageSuccessPopupControl.Hide(); }" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <!--PopUpcontrol Message FAILED-->
    <dx:ASPxPopupControl ID="ASPxPopupControl3" runat="server" ClientInstanceName="MessageErrorPopupControl"
        CloseAction="None" Height="100px" Width="269px" PopupHorizontalAlign="WindowCenter"
         PopupVerticalAlign="TopSides"  EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
        CssPostfix="Aqua" Modal="true" ModalBackgroundStyle-BackColor="White"
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowCloseButton="False">
        <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
        </LoadingPanelImage>
        <ContentStyle VerticalAlign="Top">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl5" runat="server">
                <div>
                    <table align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <dx:ASPxImage ID="ASPxImage3" runat="server" ImageUrl="~/Images/icone_projet/error.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Opération Echouée !">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton12" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="ok"
                                    Width="50px" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) {MessageErrorPopupControl.Hide();}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <!--PopUpcontrol Message CAUTION-->
    <dx:ASPxPopupControl ID="ASPxPopupControl4" runat="server" ClientInstanceName="MessageCautionPopupControl"
        CloseAction="None" Height="100px" Width="269px" PopupHorizontalAlign="WindowCenter"
         PopupVerticalAlign="TopSides"  EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
        CssPostfix="Aqua" Modal="true" ModalBackgroundStyle-BackColor="White"
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowCloseButton="False">
        <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
        </LoadingPanelImage>
        <ContentStyle VerticalAlign="Top">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl6" runat="server">
                <div>
                    <table align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <dx:ASPxImage ID="ASPxImage4" runat="server" ImageUrl="~/Images/icone_projet/caution.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Attention cet élément existe déjà !">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton13" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="ok"
                                    Width="50px">
                                    <ClientSideEvents Click="function(s, e) {MessageCautionPopupControl.Hide();}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ASPxPopupControl5" runat="server"
        ClientInstanceName="MessageAutorisationPopupControl" CloseAction="None"
        Height="100px" Width="290px" PopupHorizontalAlign="WindowCenter"
         PopupVerticalAlign="TopSides"  EnableAnimation="false"
        HeaderText=""
        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua"
        Modal="true" ModalBackgroundStyle-BackColor="White"
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
        ShowCloseButton="False">
        <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
        </LoadingPanelImage>
        <ContentStyle VerticalAlign="Top">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                <div>

                    <table align="center" cellpadding="0" cellspacing="0" class="style15">
                        <tr>
                            <td class="style17">
                                <dx:ASPxImage ID="ASPxImage1" runat="server"
                                    ImageUrl="~/Images/icone_projet/caution.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Vous ne disposez pas des droits nécessaires pour cette opération!">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">&nbsp;</td>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton1" runat="server"
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua"
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="ok"
                                    Width="50px" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) {MessageAutorisationPopupControl.Hide();}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>

                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
