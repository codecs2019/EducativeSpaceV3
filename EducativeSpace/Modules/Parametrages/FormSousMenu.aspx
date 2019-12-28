<%@ Page Title="" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true" CodeFile="FormSousMenu.aspx.cs" Inherits="EducativeSpaceApp.Modules.Parametrages.FormSousMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
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
                    <h1>Gestion des sous menus</h1>
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
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxGridView runat="server" ID="MainGridView" ClientInstanceName="gridView"
        KeyFieldName="ID_SOUSMENU" EnablePagingGestures="False" CssClass="grid-view" Width="100%" DataSourceID="MainGridViewDataSource"
        AutoGenerateColumns="False">
        
        <Columns>
            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="AllPages" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Code" FieldName="CODE_SOUSMENU" Width="10%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Intitulé" FieldName="LIBELLE_SOUSMENU" Width="35%">
                <EditItemTemplate>
                    <dx:ASPxTextBox runat="server" ID="txtLibelle" Value='<%# Bind("LIBELLE_SOUSMENU") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                        <ValidationSettings Display="Dynamic">
                            <RequiredField IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </EditItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn  Caption="Menu" FieldName="ID_MENU" Width="30%">
                <PropertiesComboBox ValueField="ID_MENU" TextField="LIBELLE_MENU" ValueType="System.Int64" DataSourceID="MenuDataSource">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
             <dx:GridViewDataTextColumn Caption="Icone" FieldName="ICONE" Width="10%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Position" FieldName="POSITION" Width="10%">
                <EditItemTemplate>
                    <dx:ASPxSpinEdit runat="server" ID="spnPosition" Value='<%# Bind("POSITION") %>' ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                        <ValidationSettings Display="Dynamic">
                            <RequiredField IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxSpinEdit>
                </EditItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ID_MENU" Visible="False">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior AllowFocusedRow="true" AllowSelectByRowClick="true" AllowEllipsisInText="true" AllowDragDrop="false" />
        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="2" />
        <SettingsSearchPanel CustomEditorID="SearchButtonEdit" />
        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Auto" ShowHeaderFilterButton="true" />
        <SettingsPager PageSize="15" EnableAdaptivity="true">
            <PageSizeItemSettings Visible="true"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" ExportSelectedRowsOnly="false" />
        <SettingsPopup>
            <EditForm>
                <SettingsAdaptivity MaxWidth="800" Mode="Always" VerticalAlign="WindowCenter"  />
            </EditForm>
        </SettingsPopup>
        <EditFormLayoutProperties UseDefaultPaddings="false">
            <Styles LayoutItem-Paddings-PaddingBottom="8" />
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
            </SettingsAdaptivity>
            <Items>
                <dx:GridViewLayoutGroup ColCount="2" GroupBoxDecoration="None">
                    <Items>
                        <dx:GridViewColumnLayoutItem ColumnName="CODE_SOUSMENU" Caption="Code" />
                        <dx:GridViewColumnLayoutItem ColumnName="LIBELLE_SOUSMENU" Caption="Libellé" ColumnSpan="2" />
                        <dx:GridViewColumnLayoutItem ColumnName="ICONE" Caption="Icone" />
                        <dx:GridViewColumnLayoutItem ColumnName="ID_MENU" Caption="Menu"  />
                        <dx:GridViewColumnLayoutItem ColumnName="POSITION" CaptionSettings-AllowWrapCaption="False" />
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
        <ClientSideEvents Init="onGridViewInit" SelectionChanged="onGridViewSelectionChanged" />
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="MenuDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_MENU" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="MainGridViewDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_SOUSMENU" SelectCommandType="StoredProcedure"
        InsertCommand="PS_E_SOUSMENU" InsertCommandType="StoredProcedure"
        UpdateCommand="PS_E_SOUSMENU" UpdateCommandType="StoredProcedure"
        DeleteCommand="PS_E_SOUSMENU" DeleteCommandType="StoredProcedure">

        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="ID_SOUSMENU" Type="Int32" />
            <asp:Parameter Name="CODE_SOUSMENU" Type="String" />
            <asp:Parameter Name="LIBELLE_SOUSMENU" Type="String" />
            <asp:Parameter Name="ID_MENU" Type="Int32" />
            <asp:Parameter Name="POSITION" Type="Int32" />
            <asp:Parameter Name="ICONE" Type="String" />
            <asp:Parameter DefaultValue="1" Name="SENDER" Type="Int32" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ID_SOUSMENU" Type="Int32" />
            <asp:Parameter Name="CODE_SOUSMENU" Type="String" />
            <asp:Parameter Name="LIBELLE_SOUSMENU" Type="String" />
            <asp:Parameter Name="ID_MENU" Type="Int32" />
            <asp:Parameter Name="POSITION" Type="Int32" />
            <asp:Parameter Name="ICONE" Type="String" />
            <asp:Parameter DefaultValue="2" Name="SENDER" Type="Int32" />
        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="ID_SOUSMENU" Type="Int32" />
            <asp:Parameter DefaultValue="3" Name="SENDER" Type="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>
</asp:Content>

