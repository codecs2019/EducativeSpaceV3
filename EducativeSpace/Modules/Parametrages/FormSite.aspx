<%@ Page Title="Entreprise" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true"  CodeFile="FormSite.aspx.cs" Inherits="Modules_Parametrages_FormSite"%>

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
    <script type="text/javascript">
        var fileNumber = 0;
        var fileName = "";
        var startDate = null;
        
        function UploadControl_OnFileUploadStart() {
            startDate = new Date();
            ClearProgressInfo();
            pcProgress.Show();
        }
        function UploadControl_OnFilesUploadComplete(e) {
            pcProgress.Hide();
            if(e.errorText)
                ShowMessage(e.errorText);
            else if (e.callbackData) {
                var data = e.callbackData;
                alert(data);
                document.getElementById("tof").src = data;
                ShowMessage("Le Fichier a été téléchargé complètement avec succès.");
            }
        }
        function ShowMessage(message) {
            TxtInfo.SetText(message);
            InfoPanel.Show();
        }
        // Progress Dialog
        function UploadControl_OnUploadingProgressChanged(args) {
            if(!pcProgress.IsVisible())
                return;
            if(args.currentFileName != fileName) {
                fileName = args.currentFileName;
                fileNumber++;
            }
            SetCurrentFileUploadingProgress(args.currentFileName, args.currentFileUploadedContentLength, args.currentFileContentLength);
            progress1.SetPosition(args.currentFileProgress);
            SetTotalUploadingProgress(fileNumber, args.fileCount, args.uploadedContentLength, args.totalContentLength);
            progress2.SetPosition(args.progress);
            UpdateProgressStatus(args.uploadedContentLength, args.totalContentLength);
        }
        function SetCurrentFileUploadingProgress(fileName, uploadedLength, fileLength) {
            lblFileName.SetText("Current File Progress: " + fileName);
            lblFileName.GetMainElement().title = fileName;
            lblCurrentUploadedFileLength.SetText( GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(fileLength) );
        }
        function SetTotalUploadingProgress(number, count, uploadedLength, totalLength) {
            lblUploadedFiles.SetText("Total Progress: " + number + ' of ' + count + " file(s)");
            lblUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(totalLength));
        }
        function ClearProgressInfo() {
            SetCurrentFileUploadingProgress("", 0, 0);
            progress1.SetPosition(0);
            SetTotalUploadingProgress(0, 0, 0, 0);
            progress2.SetPosition(0);
            lblProgressStatus.SetText('Elapsed time: 00:00:00 &ensp; Estimated time: 00:00:00 &ensp; Speed: ' + GetContentLengthString(0) + '/s');
            fileNumber = 0;
            fileName = "";
        }
        function UpdateProgressStatus(uploadedLength, totalLength) {
            var currentDate = new Date();
            var elapsedDateMilliseconds = currentDate - startDate;
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            var elapsedDate = new Date(elapsedDateMilliseconds);
            var elapsedTime = GetTimeString(elapsedDate);
            var estimatedMilliseconds = Math.floor((totalLength - uploadedLength) / speed) * 1000;
            var estimatedDate = new Date(estimatedMilliseconds);
            var estimatedTime = GetTimeString(estimatedDate);
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            lblProgressStatus.SetText('Elapsed time: ' + elapsedTime + ' &ensp; Estimated time: ' + estimatedTime + ' &ensp; Speed: ' + GetContentLengthString(speed) + '/s');
        }
        function GetContentLengthString(contentLength) {
            var sizeDimensions = [ 'bytes', 'KB', 'MB', 'GB', 'TB' ];
            var index = 0;
            var length = contentLength;
            var postfix = sizeDimensions[index];
            while(length > 1024) {
                length = length / 1024;
                postfix = sizeDimensions[++index];
            }
            var numberRegExpPattern = /[-+]?[0-9]*(?:\.|\,)[0-9]{0,2}|[0-9]{0,2}/;
            var results = numberRegExpPattern.exec(length);
            length = results ? results[0] : Math.floor(length);
            return length.toString() + ' ' + postfix;
        }
        function GetTimeString(date) {
            var timeRegExpPattern = /\d{1,2}:\d{1,2}:\d{1,2}/;
            var results = timeRegExpPattern.exec(date.toUTCString());
            return results ? results[0] : "00:00:00";
        }
    </script>
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
                    <h1>Information d'entreprise</h1>
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
    <dx:ASPxGridView runat="server" ID="GridView" ClientInstanceName="gridView" OnRowUpdating="Modifier" OnRowInserting="Enregistrer" KeyFieldName="SITE_ID" EnablePagingGestures="False" CssClass="grid-view" Width="100%">
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
            <dx:GridViewDataColumn FieldName="SITE_ID"  />
            <dx:GridViewDataColumn FieldName="ADRESSE_SITES" Caption="Commentaire" Width="100%"/>
        </Columns>

        <Templates>
            <DataRow>
                <div style="padding: 5px">
                    <table class="templateTable">
                        <tr>
                            <td class="imageCell" rowspan="4">
                                <dx:ASPxImage ID="Image1" runat="server" Width="150" ImageUrl='<%# Eval("LOGO_ENTREPRISE") %>' />
                            </td>
                            <td>
                                Raison Social :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="lblFirstName" runat="server"  Text='<%# Eval("RAISON_SOCIALE_COMPLETE") %>' />
                            </td>
                            <td>
                                Boite Postale :
                            </td>
                            <td class="value" colspan="2">
                                <dx:ASPxLabel ID="lblLastName" runat="server"  Text='<%# Eval("BOITE_POSTALE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Activités :
                            </td>
                            <td class="value" colspan="5">
                                <dx:ASPxLabel ID="lblTitle" runat="server"  Text='<%# Eval("ACTIVITES") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Adresse :
                            </td>
                            <td class="value" colspan="5">
                                <dx:ASPxLabel ID="ASPxLabel7" runat="server"  Text='<%# Eval("ADRESSE_SITES") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Adresse Complementaire :
                            </td>
                            <td class="value" colspan="5">
                                <dx:ASPxLabel ID="ASPxLabel8" runat="server"  Text='<%# Eval("ADDRESSE_COMPLEMENTAIRE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Telephone 1 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel1" runat="server"  Text='<%# Eval("TELEPHONE_STANDARD_1") %>' />
                            </td>
                            <td>
                                Telephone 2 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server"  Text='<%# Eval("TELEPHONE_STANDARD_2") %>' />
                            </td>
                            <td>
                                Telephone 3 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel3" runat="server"  Text='<%# Eval("TELEPHONE_STANDARD_3") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Cellulaire 1 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel4" runat="server"  Text='<%# Eval("TELEPHONE_MOBILE_1") %>' />
                            </td>
                            <td>
                                Cellulaire 2 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel5" runat="server"  Text='<%# Eval("TELEPHONE_MOBILE_2") %>' />
                            </td>
                            <td>
                                Cellulaire 3 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel6" runat="server"  Text='<%# Eval("TELEPHONE_MOBILE_3") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Registre de Commerce :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel9" runat="server"  Text='<%# Eval("REGISTRE_COMMERCE") %>' />
                            </td>
                            <td>
                                Compte Contribuable :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel10" runat="server"  Text='<%# Eval("COMPTE_CONTRIBUABLE") %>' />
                            </td>
                            <td>
                                Numéro CNPS :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel11" runat="server"  Text='<%# Eval("NUMERO_CNPS") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Contact 1 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel12" runat="server"  Text='<%# Eval("ID_CONTACT1") %>' />
                            </td>
                            <td>
                                Contact 2 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel13" runat="server"  Text='<%# Eval("ID_CONTACT2") %>' />
                            </td>
                            <td>
                                Contact 3 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel14" runat="server"  Text='<%# Eval("ID_CONTACT3") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Email 1 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel15" runat="server"  Text='<%# Eval("EMAIL1") %>' />
                            </td>
                            <td>
                                Email 2 :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel16" runat="server"  Text='<%# Eval("EMAIL2") %>' />
                            </td>
                            <td>
                                Site Web :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel17" runat="server"  Text='<%# Eval("WEB") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Banque :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel18" runat="server"  Text='<%# Eval("BANQUE") %>' />
                            </td>
                            <td>
                                Code Guichet :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel19" runat="server"  Text='<%# Eval("CODE_GUICHET") %>' />
                            </td>
                            <td>
                                Code Banque :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel20" runat="server"  Text='<%# Eval("CODE_BANQUE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                N° Compte :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel21" runat="server"  Text='<%# Eval("NUMERO_COMPTE_BANQUE") %>' />
                            </td>
                            <td>
                                Clé RIB :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel22" runat="server"   Text='<%# Eval("CLE_RIB") %>'/>
                            </td>
                            <td>
                                IBAN :
                            </td>
                            <td class="value">
                                <dx:ASPxLabel ID="ASPxLabel23" runat="server"   Text='<%# Eval("IBAN") %>'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="vertical-align: top;">
                                <dx:ASPxLabel ID="lblNotes" runat="server" Text='<%# Eval("DESCRIPTION_ENTREPRISE") %>' />
                            </td>
                        </tr>
                    </table>
                </div>
            </DataRow>
            <EditForm>
                <dx:ASPxPageControl runat="server" ID="pgControl" Width="100%" Border-BorderColor="White" Border-BorderWidth="0">
                            <TabPages>
                                 <dx:TabPage Text="Identification">
                                     <ContentCollection>
                                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                            <table>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Raison Sociale" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="rai" Width="350" Text='<%# Eval("RAISON_SOCIALE_COMPLETE") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Activités" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td colspan="10">
                                                        <dx:ASPxTextBox runat="server" ID="act" Width="800"  Text='<%# Eval("ACTIVITES") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Adresse" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6" ></td>
                                                    <td colspan="10">
                                                        <dx:ASPxTextBox runat="server" ID="adr"  Width="800" Text='<%# Eval("ADRESSE_SITES") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Adresse Complémentaire" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6" ></td>
                                                    <td colspan="10">
                                                        <dx:ASPxTextBox runat="server" ID="adrcom"  Width="800" Text='<%# Eval("ADDRESSE_COMPLEMENTAIRE") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Boite Postale" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6" ></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="pos"  Width="350"  Text='<%# Eval("BOITE_POSTALE") %>'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Telephone 1" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6" ></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="tel1" Text='<%# Eval("TELEPHONE_STANDARD_1") %>' />
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Telephone 2" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="tel2" Text='<%# Eval("TELEPHONE_STANDARD_2") %>' />
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Telephone 3" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="tel3" Text='<%# Eval("TELEPHONE_STANDARD_3") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Cellulaire 1" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6"></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="cel1" Text='<%# Eval("TELEPHONE_MOBILE_1") %>' />
                                                    </td>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Cellulaire 2" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td  class="auto-style6" ></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="cel2" Text='<%# Eval("TELEPHONE_MOBILE_2") %>' />
                                                    </td>
                                                    <td  class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Cellulaire 3" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6" ></td>
                                                    <td >
                                                        <dx:ASPxTextBox runat="server" ID="cel3" Text='<%# Eval("TELEPHONE_MOBILE_3") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6" ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Registre de Commerce" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="reg" Text='<%# Eval("REGISTRE_COMMERCE") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Logo" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td rowspan="9">
                                                        <dx:ASPxUploadControl ID="UploadControl" runat="server"  ClientInstanceName="UploadControl" Width="120" BrowseButtonStyle-Width="120" ShowTextBox="false" NullText="Click here to browse files..." UploadMode="Advanced" AutoStartUpload="True" BrowseButton-Text="Ajouter Photo" OnFileUploadComplete="UploadControl_FilesUploadComplete">
                                                            <AdvancedModeSettings EnableMultiSelect="True" EnableDragAndDrop="True" />
                                                            <ValidationSettings 
                                                                AllowedFileExtensions=" .jpe, .jpeg, .jpg, .gif, .png"
                                                                MaxFileSize="10000000" ShowErrors="false"></ValidationSettings>
                                                            <ClientSideEvents FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                                                              FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                                                              UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                                        </dx:ASPxUploadControl>

                                                        <dx:ASPxImage runat="server" Border-BorderColor="Black" Border-BorderWidth="1" ClientInstanceName="tof" ID="tof" Width="150" Height="120" ShowLoadingImage="true"  LoadingImageUrl="~/Content/Loading.gif" >
                                                        </dx:ASPxImage>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Compte contribuable" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxTextBox runat="server" ID="cmpt_con" Text='<%# Eval("COMPTE_CONTRIBUABLE") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Statut" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxComboBox runat="server" ID="sta" Width="300">
                                                
                                                        </dx:ASPxComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Régime d'imposition" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxComboBox runat="server" ID="regi" Width="300">
                                                
                                                        </dx:ASPxComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Numéro CNPS" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="cnps"  Text='<%# Eval("NUMERO_CNPS") %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:ContentControl>
                                     </ContentCollection>
                                 </dx:TabPage>
                                 <dx:TabPage Text="Contacts">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server"  SupportsDisabledAttribute="True">
                                            <table>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Contact 1" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxComboBox ID="con1" runat="server" DataSecurityMode="Strict" DataSourceID="PersonnelSource" DropDownStyle="DropDown" EnableCallbackMode="True" Text='<%# Eval("ID_CONTACT1") %>' TextField="MATRICULE" ValueField="ID">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <div class="frame">
                                                    <img class="photo" alt="photo" src="<%# Page.ResolveUrl(Eval("FICHIER").ToString()) %>" />
                                                </div>
                                            </td>
                                            <td class="name"><%# Eval("NOM") %> <%# Eval("PRENOM") %></td>
                                        </tr>
                                        <tr>
                                            <td class="description">
                                                <div class="contactInfo">
                                                    <%# Eval("ADRESSE") %><br />
                                                    <%# Eval("CONTACT1") %>
                                                </div>
                                                <%# Eval("EMAIL") %>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle>
                                    <SelectedStyle CssClass="selectedItem" />
                                    <HoverStyle CssClass="hoveredItem" />
                                </ItemStyle>
                            </dx:ASPxComboBox>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:MasterSuiteConnectionString %>' SelectCommand="Daf.PS_PERSONNEL" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="3" Name="INDEX" Type="Int32"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Banque" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="ban" Width="350" Text='<%# Eval("BANQUE") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Contact 2" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxComboBox ID="con2" runat="server" DataSecurityMode="Strict" DataSourceID="PersonnelSource" DropDownStyle="DropDown" EnableCallbackMode="True" Text='<%# Eval("ID_CONTACT2") %>' TextField="MATRICULE" ValueField="ID">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <div class="frame">
                                                    <img class="photo" alt="photo" src="<%# Page.ResolveUrl(Eval("FICHIER").ToString()) %>" />
                                                </div>
                                            </td>
                                            <td class="name"><%# Eval("NOM") %> <%# Eval("PRENOM") %></td>
                                        </tr>
                                        <tr>
                                            <td class="description">
                                                <div class="contactInfo">
                                                    <%# Eval("ADRESSE") %><br />
                                                    <%# Eval("CONTACT1") %>
                                                </div>
                                                <%# Eval("EMAIL") %>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle>
                                    <SelectedStyle CssClass="selectedItem" />
                                    <HoverStyle CssClass="hoveredItem" />
                                </ItemStyle>
                            </dx:ASPxComboBox>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:MasterSuiteConnectionString %>' SelectCommand="Daf.PS_PERSONNEL" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="3" Name="INDEX" Type="Int32"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                                                    </td>
                                        
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Code Guichet" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="codgui" Text='<%# Eval("CODE_GUICHET") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Contact 3" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxComboBox ID="con3" runat="server" DataSecurityMode="Strict" DataSourceID="PersonnelSource" DropDownStyle="DropDown" EnableCallbackMode="True" Text='<%# Eval("ID_CONTACT1") %>' TextField="MATRICULE" ValueField="ID">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <div class="frame">
                                                    <img class="photo" alt="photo" src="<%# Page.ResolveUrl(Eval("FICHIER").ToString()) %>" />
                                                </div>
                                            </td>
                                            <td class="name"><%# Eval("NOM") %> <%# Eval("PRENOM") %></td>
                                        </tr>
                                        <tr>
                                            <td class="description">
                                                <div class="contactInfo">
                                                    <%# Eval("ADRESSE") %><br />
                                                    <%# Eval("CONTACT1") %>
                                                </div>
                                                <%# Eval("EMAIL") %>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle>
                                    <SelectedStyle CssClass="selectedItem" />
                                    <HoverStyle CssClass="hoveredItem" />
                                </ItemStyle>
                            </dx:ASPxComboBox>
                        <asp:SqlDataSource runat="server" ID="PersonnelSource" ConnectionString='<%$ ConnectionStrings:MasterSuiteConnectionString %>' SelectCommand="Daf.PS_PERSONNEL" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="3" Name="INDEX" Type="Int32"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                                                    </td>
                                        
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Code Banque" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="codban" Text='<%# Eval("CODE_BANQUE") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr >
                                                    <td rowspan="6" class="auto-style6"></td>
                                                    <td rowspan="6" class="auto-style6">
                                                        <dx:ASPxLabel Text="Description Entreprise" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5" rowspan="6">
                                                        <dx:ASPxMemo runat="server" Rows="5" ID="des" Width="350" Text='<%# Eval("DESCRIPTION_ENTREPRISE") %>' />
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Numéro de Compte" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="ncmpt"  Width="300" Text='<%# Eval("NUMERO_COMPTE_BANQUE") %>' />
                                                    </td>
                                                </tr>
                                    
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Clé RIB" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="rib" Text='<%# Eval("CLE_RIB") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7" ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td ></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="IBAN" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="iban" Width="350" Text='<%# Eval("IBAN") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Adresse email 1" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="ema1" Width="350" Text='<%# Eval("EMAIL1") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td ></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Adresse email 2" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="ema2" Width="350" Text='<%# Eval("EMAIL2") %>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style6"></td>
                                                    <td>
                                                        <dx:ASPxLabel Text="Site Web" runat="server"></dx:ASPxLabel>
                                                    </td>
                                                    <td class="auto-style6"></td>
                                                    <td colspan="5">
                                                        <dx:ASPxTextBox runat="server" ID="web" Width="350" Text='<%# Eval("WEB") %>' >

                                                        </dx:ASPxTextBox>
                                                    </td>
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
                            <SettingsText  CommandCancel="ANNULER" CommandUpdate="VALIDER"  PopupEditFormCaption="Fiche d'entreprise" />
                            <Settings ShowColumnHeaders="false" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto" />
                            <SettingsExport EnableClientSideExportAPI="true" ExportSelectedRowsOnly="true" />
                            <SettingsPopup>
                                <EditForm>
                                    <SettingsAdaptivity MaxWidth="1000" Mode="Always" VerticalAlign="WindowTop" />
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


    <dx:ASPxPopupControl ID="ASPxPopupControl6" runat="server" ClientInstanceName="pcProgress" Modal="True" HeaderText="Uploading"
        PopupAnimationType="None" CloseAction="None" PopupHorizontalAlign="WindowCenter"  PopupVerticalAlign="TopSides"  Width="460px"
        AllowDragging="true" ShowPageScrollbarWhenModal="True" ShowCloseButton="False" ShowFooter="True">
        <SettingsAdaptivity Mode="Always" MaxWidth="460px" HorizontalAlign="WindowCenter" VerticalAlign="WindowTop" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl7" runat="server" SupportsDisabledAttribute="True">
                <div style="overflow: hidden; width: 280px; float: left;">
                    <dx:ASPxLabel ID="lblFileName" runat="server" ClientInstanceName="lblFileName" Text="" Wrap="False" />
                </div>
                <div style="float: right">
                    <dx:ASPxLabel ID="lblCurrentUploadedFileLength" runat="server" ClientInstanceName="lblCurrentUploadedFileLength"
                    Text="" Wrap="False" />
                </div>
                <div class="Spacer" style="height: 6px;"></div>
                <dx:ASPxProgressBar ID="ASPxProgressBar1" runat="server" Height="21px" Width="100%" ClientInstanceName="progress1" />
                <div class="Spacer" style="height: 12px;"></div>
                <dx:ASPxLabel ID="lblUploadedFiles" runat="server" ClientInstanceName="lblUploadedFiles" Text="" Wrap="False" />
                <div style="float: right">
                    <dx:ASPxLabel ID="lblUploadedFileLength" runat="server" ClientInstanceName="lblUploadedFileLength"
                        Text="" Wrap="False" />
                </div>
                <div class="Spacer" style="height: 6px;"></div>
                <dx:ASPxProgressBar ID="ASPxProgressBar2" runat="server" CssClass="BottomMargin" Height="21px" Width="100%"
                    ClientInstanceName="progress2" />
                <div class="Spacer" style="height: 12px;"></div>
                <dx:ASPxLabel ID="lblProgressStatus" runat="server" ClientInstanceName="lblProgressStatus" Text="" Wrap="True" />
            </dx:PopupControlContentControl>
        </ContentCollection>
        <FooterTemplate>
            <div style="overflow: hidden;">
                <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="False" Text="Cancel" ClientInstanceName="btnCancel" Width="100px" style="float: right">
                    <ClientSideEvents Click="function(s, e) { UploadControl.Cancel(); }" />
                </dx:ASPxButton>
            </div>
        </FooterTemplate>
        <FooterStyle><Paddings Padding="5px" PaddingRight="10px" /></FooterStyle>
    </dx:ASPxPopupControl>
</asp:Content>












