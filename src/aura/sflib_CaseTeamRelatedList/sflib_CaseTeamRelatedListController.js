({
    /**
     * doInit
     *
     * @description Initialise the table columns and request the Case Team data from the server
     * @param component
     * @param event
     * @param helper
     */
    doInit: function (component, event, helper) {
        helper.initColumns(component);
        helper.fetchData(component);
        helper.checkRecordAccess(component);
    },


    /**
     * handleCaseTeamUpdatedEvent
     *
     * @description When the CaseTeamUpdated event is fired, reload Case Team data from server
     *              and clear selected Case Members
     * @param component
     * @param event
     * @param helper
     */
    handleCaseTeamUpdatedEvent: function (component, event, helper) {
        helper.fetchData(component);
        component.set("v.selectedMemberIds", []);
    },


    /**
     * onClickRemoveMemberButton
     *
     * @description Check if there are selected members and removes them form the Case Team
     * @param component
     * @param event
     * @param helper
     */
    onClickRemoveMemberButton: function (component, event, helper) {
        console.log('onClickRemoveMemberButton');
        var selectedMembers = component.get("v.selectedMemberIds");
        if (selectedMembers != null && selectedMembers.length > 0) {
            helper.removeSelectedMembers(component, selectedMembers);
        }
    },


    /**
     * onRowSelection
     *
     * @description Add the selected members from the table to the attribute that holds the CaseTeamMember.Id values
     * @param component
     * @param event
     * @param helper
     */
    onRowSelection: function (component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        var selectedMemberIds = new Array();
        for (var i = 0; i < selectedRows.length; i++) {
            selectedMemberIds.push(selectedRows[i].caseTeamMemberId);
        }
        component.set("v.selectedMemberIds", selectedMemberIds);
    }
})