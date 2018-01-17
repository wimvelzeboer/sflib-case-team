({

    /**
     * doInit
     *
     * @description Component constructor
     * @param component
     * @param event
     * @param helper
     */
    doInit: function (component, event, helper) {
        helper.fetchMemberRoles(component);
    },


    /**
     * onClickAddMemberButton
     *
     * @description Actions to perform when the primary 'Add Member' button is clicked
     * @param component
     * @param event
     * @param helper
     */
    onClickAddMemberButton: function (component, event, helper) {
        helper.openModal(component);
    },


    /**
     * onClickOkButton
     *
     * @description Actions to perform when the 'Add Member' button in the modal is clicked
     * @param component
     * @param event
     * @param helper
     */
    onClickOkButton: function (component, event, helper) {
        helper.closeModal(component);
        helper.addMemberToCaseTeam(component);
    },


    /**
     * onMemberRoleChange
     *
     * @description When member role is changed, store value and validate the form again
     * @param component
     * @param event
     * @param helper
     */
    onMemberRoleChange: function (component, event, helper) {
        component.set('v.memberRoleId', component.find("InputMemberRole").get("v.value"));
        helper.validateForm(component);
    },


    /**
     * onMemberIdChanged
     *
     * @description When the Member Id is changed, validate the form again
     * @param component
     * @param event
     * @param helper
     */
    onMemberIdChanged: function (component, event, helper) {
        helper.validateForm(component);
    },


    /**
     * closeModal
     *
     * @description Closes the modal in the UI
     */
    closeModal: function (component, event, helper) {
        helper.closeModal(component);
    }
})