<%@ Page Title="" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true" CodeFile="FormProfilLien.aspx.cs" Inherits="SoroZieApp.Modules.Parametrages.FormProfilLien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <style>
        table.foobar td {
            padding: 1%;
            text-align: left;
            width: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
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
                    <h1>Gestion des liens par profil</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Ajouter" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/add.svg" />
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
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="MainGridView" ClientInstanceName="gridView" OnRowInserting="MainGridView_RowInserting" OnRowDeleting="MainGridView_RowDeleting"
        KeyFieldName="RoleId" EnablePagingGestures="False" CssClass="grid-view" Width="100%"
        AutoGenerateColumns="False">
        <Columns>
            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="AllPages" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Profil" FieldName="RoleName" Width="95%">
                <EditItemTemplate>
                    <dx:ASPxTextBox runat="server" ID="txtProfil" Value='<%# Bind("RoleName") %>'
                        ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                        <ValidationSettings Display="Dynamic">
                            <RequiredField IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </EditItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
        <SettingsSearchPanel CustomEditorID="SearchButtonEdit" />
        <SettingsDetail ShowDetailRow="true" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto" ShowHeaderFilterButton="true" />
        <SettingsPager PageSize="15" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" ExportSelectedRowsOnly="false" />
        <SettingsPopup>
            <EditForm>
                <SettingsAdaptivity MaxWidth="800" Mode="Always" VerticalAlign="WindowCenter" />
            </EditForm>
        </SettingsPopup>
        <EditFormLayoutProperties UseDefaultPaddings="false">
            <Styles LayoutItem-Paddings-PaddingBottom="8">
                <LayoutItem>
                    <Paddings PaddingBottom="8px"></Paddings>
                </LayoutItem>
            </Styles>
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
            </SettingsAdaptivity>
            <Items>
                <dx:GridViewLayoutGroup ColCount="1" GroupBoxDecoration="None">
                    <Items>
                        <dx:GridViewColumnLayoutItem ColumnName="RoleName" Caption="Profil" />
                        <dx:EditModeCommandLayoutItem Width="100%" HorizontalAlign="Right" />
                    </Items>
                </dx:GridViewLayoutGroup>
            </Items>
        </EditFormLayoutProperties>
        <Styles>
            <Cell Wrap="false" />
            <PagerBottomPanel CssClass="pager" />
            <FocusedRow CssClass="focused" />
        </Styles>
        <ClientSideEvents SelectionChanged="onGridViewSelectionChanged" />
        <%--Init="onGridViewInit"--%>

        <Templates>
            <DetailRow>
                <div style="padding: 3px 3px 2px 3px">
                    <dx:ASPxGridView ID="ThemeGridSite" ClientInstanceName="ThemeGridSite" runat="server"
                        DataSourceID="UserProfileDataSource" KeyFieldName="ID_USERPROFIL" Width="100%" OnBeforePerformDataSelect="GridPage_DataSelect">
                        <Settings HorizontalScrollBarMode="Auto" />

                        <Columns>
                            <dx:GridViewDataTextColumn Caption="Lien" FieldName="LIBELLE_LIENSOUSMENU" Width="40%" />
                            <dx:GridViewDataComboBoxColumn Caption="Droit" FieldName="DROIT" Width="10%">
                                <PropertiesComboBox>
                                    <Items>
                                        <dx:ListEditItem Text="Consultation" Value="s" />
                                        <dx:ListEditItem Text="Création/Modification" Value="c" />
                                        <dx:ListEditItem Text="Suppression" Value="d" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn Caption="Tiers" FieldName="TIERS" Width="10%" />
                            <dx:GridViewDataTextColumn Caption="Journaux" FieldName="CODE_JOURNAL" Width="10%" />
                            <dx:GridViewDataTextColumn Caption="Type de document" FieldName="TYPEDOCUMENT" Width="20%" />
                            <dx:GridViewDataTextColumn Caption="Statut" FieldName="LIBELLE_STATUT" Width="20%" />
                            <dx:GridViewDataTextColumn Caption="Statut" FieldName="ID_STATUT" Width="20%" Visible="false" />
                            <dx:GridViewCommandColumn VisibleIndex="0" Width="5%" ShowDeleteButton="true" ShowNewButtonInHeader="true">
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <SettingsCommandButton>
                            <NewButton ButtonType="Image">
                                <Image Url="~/Content/16x16/ajouter2.png">
                                </Image>
                            </NewButton>
                            <EditButton ButtonType="Image">
                                <Image Url="~/Content/16x16/35.png">
                                </Image>
                            </EditButton>
                            <DeleteButton ButtonType="Image">
                                <Image Url="~/Content/16x16/Poubelle.png">
                                </Image>
                            </DeleteButton>
                            <CancelButton ButtonType="Image">
                                <Image Url="~/Content/100x23/ANNULER.png">
                                </Image>
                            </CancelButton>
                            <UpdateButton ButtonType="Image">
                                <Image Url="~/Content/100x23/VALIDER.png">
                                </Image>
                            </UpdateButton>
                        </SettingsCommandButton>
                        <Templates>
                            <EditForm>
                                <table class="foobar">
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Lien du sous menu:">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="CmbLienSM" runat="server" DataSourceID="MainGridViewDataSource"
                                                ValueField="ID_LIENSOUSMENU" Value='<%# Bind("ID_LIENSOUSMENU") %>' Width="100%">
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Intitulé" FieldName="LIBELLE_LIENSOUSMENU" />
                                                </Columns>
                                                <ValidationSettings Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Droit :">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbDroit" runat="server" ValueField="DROIT" Value='<%# Bind("DROIT") %>' Width="100%" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Consultation" Value="s" />
                                                    <dx:ListEditItem Text="Création/Modification" Value="c" />
                                                    <dx:ListEditItem Text="Suppression" Value="d" />
                                                </Items>
                                                <ValidationSettings Display="Dynamic">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Journaux :">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <%--<dx:ASPxGridLookup ID="chkListJourn" runat="server" DataSourceID="SqlDataJournal" KeyFieldName="CODE_JOURNAL" Value='<%# Bind("CODE_JOURNAL") %>' TextFormatString="{0}" MultiTextSeparator="; "
                                                SelectionMode="Multiple" Width="100%">
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowSelectCheckbox="true"></dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn Caption="Code" FieldName="CODE_JOURNAL"></dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridLookup>--%>
                                            <dx:ASPxCheckBoxList ID="chkListJourn" runat="server" DataSourceID="SqlDataJournal" ValueField="CODE_JOURNAL" TextField="CODE_JOURNAL" AutoPostBack="false" Width="100%" RepeatColumns="8" RepeatLayout="Table">
                                            </dx:ASPxCheckBoxList>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Tiers :">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxCheckBoxList ID="chkListTiers" runat="server" Width="100%" RepeatColumns="8" AutoPostBack="false" RepeatLayout="Table" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Client" Value="0" />
                                                    <dx:ListEditItem Text="Fournisseur" Value="1" />
                                                    <dx:ListEditItem Text="Salarié" Value="2" />
                                                    <dx:ListEditItem Text="Autre" Value="3" />
                                                </Items>

                                            </dx:ASPxCheckBoxList>
                                        </td>
                                        <%--<td>
                                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Type de document :">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxCheckBoxList ID="chkListDoc" runat="server" Width="100%" AutoPostBack="false" RepeatColumns="4" RepeatLayout="Flow" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Proformat" Value="PF" />
                                                    <dx:ListEditItem Text="Bon de commande" Value="BC" />
                                                    <dx:ListEditItem Text="Bon de livraison" Value="BL" />
                                                    <dx:ListEditItem Text="Facture" Value="FT" />
                                                </Items>
                                            </dx:ASPxCheckBoxList>
                                        </td>--%>
                                    </tr>

                                    ---------------------

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxStatut" runat="server" Text="Statut :">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>

                                            <dx:ASPxGridLookup ID="chkStatutJourn" runat="server" DataSourceID="SqlDataStatut" Value='<%# Bind("ID_STATUT") %>' KeyFieldName="ID_STATUT" TextField="LIBELLE_STATUT" TextFormatString="{1}" MultiTextSeparator="; "
                                                Width="30%">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn Caption="Code" FieldName="ID_STATUT"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Statut" FieldName="LIBELLE_STATUT"></dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridLookup>

                                        </td>
                                        <td></td>
                                        <td></td>

                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td>
                                            <dx:ASPxCheckBoxList ID="ASPxCheckAfficherMontant" runat="server" Width="50%" AutoPostBack="false" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Afficher Montant" Value="1" />
                                                </Items>
                                            </dx:ASPxCheckBoxList>
                                        </td>
                                        <td></td>
                                        <td></td>

                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td>
                                            <dx:ASPxCheckBoxList ID="ASPxCheckAccederDate" runat="server" Width="50%" AutoPostBack="false" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Acceder Date" Value="1" />
                                                </Items>
                                            </dx:ASPxCheckBoxList>
                                        </td>
                                        <td></td>
                                        <td></td>

                                    </tr>

                                </table>
                                <center>
                                <div>
                                    <dx:ASPxGridViewTemplateReplacement ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
                                    <dx:ASPxGridViewTemplateReplacement ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
                                </div>
                                </center>
                            </EditForm>
                        </Templates>
                        <Settings ShowFilterRow="true" AutoFilterCondition="Contains" />
                        <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" AllowFocusedRow="true" />
                        <SettingsText ConfirmDelete="Voulez-vous Supprimer ? " />
                    </dx:ASPxGridView>
            </DetailRow>

        </Templates>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="UserProfileDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_USERPROFILE" SelectCommandType="StoredProcedure"
        InsertCommand="PS_E_USERPROFILE" InsertCommandType="StoredProcedure" OnInserting="UserProfileDataSource_Inserting"
        DeleteCommand="PS_E_USERPROFILE" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="ID_ROLE" Name="ID_ROLE" />
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="ID_LIENSOUSMENU" Type="Int32" />
            <asp:Parameter Name="DROIT" Type="String" />
            <asp:Parameter Name="CODE_JOURNAL" />
            <asp:Parameter Name="TIERS" Type="String" />
            <asp:Parameter Name="ID_STATUT" Type="String" />

            <asp:Parameter Name="AFFICHER_MONTANT" Type="Byte" />
            <asp:Parameter Name="ACCEDER_DATE" Type="Byte" />

            <%--<asp:Parameter Name="TYPEDOCUMENT" Type="String" />--%>
            <asp:SessionParameter SessionField="ID_ROLE" Name="ID_ROLE" />
            <asp:Parameter DefaultValue="1" Name="SENDER" Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID_USERPROFIL" Type="Int32" />
            <asp:Parameter DefaultValue="3" Name="SENDER" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MainGridViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_LIENSOUSMENU" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="ID_ROLE" Name="Id_Role" />
            <asp:Parameter DefaultValue="7" Name="SENDER" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataJournal" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="compta.PS_JOURNAL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataStatut" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="gmr.PS_TBL_STATUT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
