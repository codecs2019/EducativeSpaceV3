<%@ Page Title="" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true" CodeFile="FormUserLienSousMenu.aspx.cs" Inherits="SoroZieApp.Modules.Parametrages.FormUserLienSousMenu" %>

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
                    <h1>Affectation des profils aux utilisateurs</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Ajouter" Alignment="Right" AdaptivePriority="2">
                <Image Url="~/Content/Images/add.svg" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Editer" Alignment="Right" AdaptivePriority="2" Enabled="false">
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
        KeyFieldName="ID_USER_LIEN" EnablePagingGestures="False" CssClass="grid-view" Width="100%"
        DataSourceID="MainGridViewDataSource"
        AutoGenerateColumns="False">
        <Columns>
            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="AllPages" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
            <dx:GridViewDataComboBoxColumn Caption="Profil" FieldName="RoleName" Width="10%">
                <PropertiesComboBox ValueField="RoleId" TextField="RoleName" ValueType="System.Guid" DataSourceID="RoleDataSource">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="UserName" FieldName="UserId" Width="15%">
                <PropertiesComboBox ValueField="UserId" TextField="UserName" ValueType="System.Guid" DataSourceID="SqlUserDataSource">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic"></ValidationSettings>
                </PropertiesComboBox>
                <%--<EditItemTemplate>
                    <dx:ASPxComboBox ID="cmbLogin" runat="server" DataSourceID="SqlUserDataSource" ValueField="UserId" 
                        ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>">
                        <Columns>
                            <dx:ListBoxColumn Caption="Login" FieldName="UserName" />
                            <dx:ListBoxColumn Caption="Matricule" FieldName="Matricule" />
                            <dx:ListBoxColumn Caption="Nom" FieldName="Nom" />
                            <dx:ListBoxColumn Caption="Prénoms" FieldName="Prenom" />
                        </Columns>
                        <ValidationSettings Display="Dynamic">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </EditItemTemplate>--%>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Matricule" FieldName="Matricule" Width="10%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nom" FieldName="NOM" Width="10%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Prénoms" FieldName="PRENOM" Width="30%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DATE" Caption="Date" Width="10%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LIBELLE_SITE" Caption="Site" Width="20%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RoleId" Visible="false">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="UserId" Visible="false">
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
                <SettingsAdaptivity MaxWidth="800" Mode="Always" VerticalAlign="WindowCenter" />
            </EditForm>
        </SettingsPopup>
        <EditFormLayoutProperties UseDefaultPaddings="false">
            <Styles LayoutItem-Paddings-PaddingBottom="8" />
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
            </SettingsAdaptivity>
            <Items>
                <dx:GridViewLayoutGroup ColCount="1" GroupBoxDecoration="None">
                    <Items>
                        <dx:GridViewColumnLayoutItem ColumnName="RoleName" Caption="Profil" />
                        <dx:GridViewColumnLayoutItem ColumnName="UserId" Caption="UserName" />
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

    <asp:SqlDataSource ID="RoleDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="SELECT RoleId,RoleName FROM [aspnet_Roles]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlUserDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_UserLIENSOUSMENU" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="SENDER" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MainGridViewDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>"
        SelectCommand="PS_E_UserLIENSOUSMENU" SelectCommandType="StoredProcedure"
        InsertCommand="PS_E_UserLIENSOUSMENU" InsertCommandType="StoredProcedure"
        DeleteCommand="PS_E_UserLIENSOUSMENU" DeleteCommandType="StoredProcedure">

        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="SENDER" Type="Int32" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="RoleName" Type="String" />
            <asp:Parameter Name="UserId" Type="String" />
            <asp:Parameter DefaultValue="4" Name="SENDER" Type="Int32" />
        </InsertParameters>

        <DeleteParameters>
            <asp:Parameter Name="ID_USER_LIEN" Type="Int32" />
            <asp:Parameter DefaultValue="5" Name="SENDER" Type="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>
</asp:Content>
