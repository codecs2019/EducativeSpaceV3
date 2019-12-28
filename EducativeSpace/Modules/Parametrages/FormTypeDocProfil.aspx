<%@ Page Title="" Language="C#" MasterPageFile="~/StartRoot.master" AutoEventWireup="true"
    CodeFile="FormTypeDocProfil.aspx.cs" Inherits="Web_FormTypeDocProfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <style>
        table.foobar td {
            padding: 1%;
            text-align: left;
            width: 300px;
        }
    </style>
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageToolbar" runat="Server">
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
                    <h1>Affectation des types de documents aux profils</h1>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="Server">
    <dx:ASPxGridView ID="MainGridView" runat="server" AutoGenerateColumns="False" KeyFieldName="ID_TYPEDOC_PROFIL"
        OnRowDeleting="Delete" OnRowUpdating="Modifier" OnRowInserting="Enregistrer"
        Width="100%" ClientInstanceName="gridView">
        <SettingsText PopupEditFormCaption="Affectation des types de documents aux profils" />
        <ClientSideEvents EndCallback="function(s, e) {
                                        var es = s.cpShowPopup.split('|')[0];
                                        var mesg = s.cpShowPopup.split('|')[1]

                                        if( (es =='SUCCES') || (es =='DELETE_SUCCES') || (es =='UPDATE_SUCCES')) { 
                                            ASPxLabelsucces.SetText(mesg);
                                           MessageSuccessPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='ECHEC') { 
                                            echeclabel.SetText(mesg);
                                            MessageErrorPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='UNEXPECTED_ERROR') { 
                                            echeclabel.SetText(mesg);
                                            MessageErrorPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='CAUTION') { 
                                            ASPxLabel6caution.SetText(mesg);
                                            MessageCautionPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        if(es=='NO_AUTHORIZATION') { 
                                            ASPxLabel1Droit.SetText(mesg);
                                            MessageAutorisationPopupControl.Show();
                                            s.cpShowPopup='false';
                                            }
                                        }" />
        <Columns>
            <dx:GridViewDataTextColumn Caption="ID_TYPEDOC_PROFIL" FieldName="ID_TYPEDOC_PROFIL" Visible="False" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="RoleId" FieldName="RoleId" Visible="False"
                VisibleIndex="1" Width="15%">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Role" FieldName="RoleName" VisibleIndex="2" Width="15%">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="ID_TYPEDOCUMENT" FieldName="ID_TYPEDOCUMENT" Visible="False"
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Type Document" FieldName="LIBELLE_TYPEDOC"
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn Caption="Statut" FieldName="ID_STATUT" VisibleIndex="3" Visible="False">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Statut" FieldName="STATUT"
                VisibleIndex="3" Width="15%">
               
            </dx:GridViewDataTextColumn>

        </Columns>
        <SettingsCommandButton>
            <CancelButton ButtonType="Image" Image-Url="~/Content/100x23/ANNULER.png">
            </CancelButton>
            <UpdateButton ButtonType="Image" Image-Url="~/Content/100x23/VALIDER.png">
            </UpdateButton>
        </SettingsCommandButton>
        <SettingsBehavior ConfirmDelete="true" AllowFocusedRow="True" />
        <SettingsEditing PopupEditFormWidth="450px" PopupEditFormModal="False" Mode="PopupEditForm"
            PopupEditFormHorizontalAlign="WindowCenter" />
        <Settings ShowFilterRow="true" />
        <SettingsText ConfirmDelete="Voulez-Vous Supprimer ? " />
        <SettingsLoadingPanel ImagePosition="Top" />
        <SettingsPopup>
            <EditForm HorizontalAlign="Center" Modal="True" VerticalAlign="Middle" />
        </SettingsPopup>
        <SettingsExport EnableClientSideExportAPI="true" ExportSelectedRowsOnly="false" />

        <Templates>
            <EditForm>
                <table class="foobar">

                    <tr>
                        <td>Role:</td>
                        <td>
                            <dx:ASPxComboBox ID="cmbrole" runat="server" DataSecurityMode="Strict" DataSourceID="Sqlrole" DropDownStyle="DropDown" EnableCallbackMode="True" Text='<%# Eval("RoleId")%>' TextField="RoleName" ValueField="RoleId">
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="Sqlrole" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>" SelectCommand="SELECT [RoleId], [RoleName] FROM [dbo].[aspnet_Roles]"></asp:SqlDataSource>
                            
                        </td>
                    </tr>

                    <tr>
                        <td>Type Document:</td>
                        <td>
                            <dx:ASPxComboBox ID="cmbtypedoc" runat="server" DataSecurityMode="Strict" DataSourceID="Sqltypedoc" DropDownStyle="DropDown" EnableCallbackMode="True" Text='<%# Eval("ID_TYPEDOCUMENT")%>' TextField="LIBELLE_TYPEDOC" ValueField="ID_TYPEDOCUMENT">
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource ID="Sqltypedoc" runat="server" ConnectionString="<%$ ConnectionStrings:MasterSuiteConnectionString %>" SelectCommand="SELECT [ID_TYPEDOCUMENT], [LIBELLE_TYPEDOC] FROM [dbo].[TYPE_DOC]"></asp:SqlDataSource>
                            
                        </td>
                    </tr>

                    
                    
                    <tr>
                        <td>Statut:</td>
                        <td>
                            <dx:ASPxComboBox ID="cmbStatut" runat="server" Text='<%# Eval("STATUT") %>'>
                                                                <Items>
                                                                    <dx:ListEditItem Text="Saisi" Value="0" />
                                                                    <dx:ListEditItem Text="Validé" Value="1" />
                                                                    <dx:ListEditItem Text="En cours" Value="2" />
                                                                    <dx:ListEditItem Text="Achevé" Value="3" />
                                                                    <dx:ListEditItem Text="Clôturé" Value="4" />
                                                                </Items>
                                                                <ValidationSettings Display="Dynamic">
                                                                    <RequiredField IsRequired="True" />
                                                                </ValidationSettings>


                           </dx:ASPxComboBox>
                        </td>
                    </tr>

                    
                </table>
                <center>
                    <div>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1" runat="server" ReplacementType="EditFormUpdateButton" />
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement2" runat="server" ReplacementType="EditFormCancelButton" />
                    </div>
                </center>
                <br />
            </EditForm>
        </Templates>
    </dx:ASPxGridView>

    <!--PopUpcontrol Message SUCCESS-->
    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" ClientInstanceName="MessageSuccessPopupControl"
        CloseAction="None" Height="100px" Width="269px" PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter" EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
        CssPostfix="Aqua" Modal="true" ModalBackgroundStyle-BackColor="White"
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowCloseButton="False">
        <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
        </LoadingPanelImage>
        <ContentStyle VerticalAlign="Top">
        </ContentStyle>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server">
                <div>
                    <table align="center" cellpadding="10" cellspacing="0">
                        <tr>
                            <td>
                                <dx:ASPxImage ID="ASPxImage2" runat="server" ImageUrl="~/Images/icone_projet/documentinfo.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel4"  ClientInstanceName="ASPxLabelsucces" runat="server" Text="Opération effectuée avec succès !">
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
        PopupVerticalAlign="WindowCenter" EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
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
                                <dx:ASPxLabel ID="ASPxLabel5" ClientInstanceName="echeclabel" runat="server" Text="Opération Echouée !">
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
        PopupVerticalAlign="WindowCenter" EnableAnimation="false" HeaderText="" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
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
                                <dx:ASPxLabel ID="ASPxLabel6" ClientInstanceName="ASPxLabel6caution" runat="server" Text="Attention cet élément existe déjà !">
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

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server"
        ClientInstanceName="MessageAutorisationPopupControl" CloseAction="None"
        Height="100px" Width="290px" PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter" EnableAnimation="false"
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
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div>

                    <table align="center" cellpadding="0" cellspacing="0" class="style15">
                        <tr>
                            <td class="style17">
                                <dx:ASPxImage ID="ASPxImage1" runat="server"
                                    ImageUrl="~/Images/icone_projet/caution.png">
                                </dx:ASPxImage>
                            </td>
                            <td style="text-align: center">
                                <dx:ASPxLabel ID="ASPxLabel1" ClientInstanceName="ASPxLabel1Droit" runat="server" Text="Vous ne disposez pas des droits nécessaires pour cette opération!">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">&nbsp;</td>
                            <td align="center">
                                <dx:ASPxButton ID="ASPxButton5" runat="server"
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
