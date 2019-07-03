(function () {
    var keyValueEdit;
    function onGridViewInit(s, e) {
        AddAdjustmentDelegate(adjustGridView);
        updateToolbarButtonsState();
    }
    function onGridViewSelectionChanged(s, e) {
        updateToolbarButtonsState();
    }
    function adjustGridView() {
        gridImmo.AdjustControl();
    }
    function updateToolbarButtonsState() {
        var enabled = gridImmo.GetSelectedRowCount() > 0;
        pageToolbar.GetItemByName("Delete").SetEnabled(enabled);
        pageToolbar.GetItemByName("Export").SetEnabled(enabled);
        pageToolbar.GetItemByName("Edit").SetEnabled(gridImmo.GetFocusedRowIndex() !== -1);
    }

    function popup_ShownEdit(s, e) {
        callbackPanelEdit.PerformCallback(keyValueEdit);
    }

    //function onPageToolbarItemClick(s, e) {
    //    alert('');
    //    switch (e.item.name) {
    //        case "ToggleFilterPanel":
    //            toggleFilterPanel();
    //            break;
    //        case "New":
    //            alert('');
    //            keyValueEdit = -1;
    //            alert(keyValueEdit);
    //            callbackPanelEdit.SetContentHtml("");
    //            PopControlEdit.Show(s);
    //            //gridImmo.AddNewRow();
    //            break;
    //        case "Edit":
    //            gridImmo.StartEditRow(gridImmo.GetFocusedRowIndex());
    //            break;
    //        case "Delete":
    //            deleteSelectedRecords();
    //            break;
    //        case "Export":
    //            gridImmo.ExportTo(ASPxClientGridViewExportFormat.Xlsx);
    //            break;
    //    }
    //}

    //function deleteSelectedRecords() {
    //    if (confirm('Confirmer la suppression ?')) {
    //        //gridImmo.PerformCallback('delete');
    //        var index = gridImmo.GetFocusedRowIndex();
    //        gridImmo.DeleteRow(index);

    //    }
    //}

    function onFiltersNavBarItemClick(s, e) {
        var filters = {
            All: "",
            Active: "[Status] = 1",
            Bugs: "[Kind] = 1",
            Suggestions: "[Kind] = 2",
            HighPriority: "[Priority] = 1"
        };
        gridImmo.ApplyFilter(filters[e.item.name]);
        HideLeftPanelIfRequired();
    }

    function toggleFilterPanel() {
        filterPanel.Toggle();
    }

    function onFilterPanelExpanded(s, e) {
        adjustPageControls();
        searchButtonEdit.SetFocus();
    }

    window.onGridViewInit = onGridViewInit;
    window.onGridViewSelectionChanged = onGridViewSelectionChanged;
    //window.onPageToolbaSrItemClick = onPageToolbarItemClick;
    window.onFilterPanelExpanded = onFilterPanelExpanded;
    window.onFiltersNavBarItemClick = onFiltersNavBarItemClick;
})();