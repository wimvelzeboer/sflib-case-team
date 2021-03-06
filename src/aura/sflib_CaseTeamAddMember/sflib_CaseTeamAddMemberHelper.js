/**
 *  This file is part of sflib.
 *
 *  sflib is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License,
 *  or any later version.
 *
 *  sflib is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with sflib.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  @author: architect William Velzeboer  wim@velzeboer.nl
 *  @date: January 2018
 *  @version: 1.0
 */
({

    /**
     * addMemberToCaseTeam
     *
     * @description Send request to the server for adding a new member to a Case Team
     * @param component
     */
    addMemberToCaseTeam: function (component) {
        var action = component.get("c.addCaseTeamMember");
        action.setParams({
            caseId: component.get('v.caseRecordId'),
            memberId: component.get('v.memberId'),
            roleId: component.get('v.memberRoleId')
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.onAddMemberSuccess(response, component);
            }
            else if (state === "ERROR") {
                this.onControllerFailure(response)
            }
        });
        $A.enqueueAction(action);
    },


    /**
     * closeModal
     *
     * @description Deactive modal in the User Interface
     * @param component
     */
    closeModal: function (component) {
        $A.util.removeClass(component.find('Modalbackdrop'), 'slds-backdrop_open');
        $A.util.removeClass(component.find('Modalbox'), 'slds-fade-in-open');
    },


    /**
     * disableOkButton
     *
     * @description Disables the OK button in the UI
     * @param component
     */
    disableOkButton: function (component) {
        component.find("okButton").set("v.disabled", true);
    },


    /**
     * enableOkButton
     *
     * @description Enables the OK button in the UI
     * @param component
     */
    enableOkButton: function (component) {
        component.find("okButton").set("v.disabled", false);
    },


    /**
     * fireEventCaseTeamUpdated
     *
     * @description Fires the sflib_CaseTeamUpdated event
     * @param component
     */
    fireEventCaseTeamUpdated: function (component) {
        var event = component.getEvent("sflib_CaseTeamUpdated");
        event.fire();
    },


    /**
     * fetchMemberRoles
     *
     * @description Requests the member role list from the server
     * @param component
     */
    fetchMemberRoles: function (component) {
        var action = component.get("c.getCaseTeamMemberRoles");

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.onFetchTeamMemberRolesSuccess(response, component);
            }
            else if (state === "ERROR") {
                this.onControllerFailure(response)
            }
        });
        $A.enqueueAction(action);
    },


    /**
     * onAddMemberSuccess
     *
     * @description When a new member is succesfully added to the Case Team,
     *              reset the form and fire sflib_CaseTeamUpdated event
     * @param response
     * @param component
     */
    onAddMemberSuccess: function (response, component) {
        var returnValue = response.getReturnValue();
        if (returnValue == 'SUCCESS') {
            this.showToast('success', 'SUCCESS', 'Member Added succesfully to the case team');
            this.fireEventCaseTeamUpdated(component);
            component.set("v.memberRoleId", "");
            component.set("v.memberId", "");
            component.find("InputMemberRole").set("v.value", "");
        }
        else if (returnValue == 'DUPLICATE_VALUE') {
            this.showToast('error', 'FAILED', 'The user is already member of the case team');
        }
        else {
            this.showToast('error', 'ERROR', 'Unknown server side error, please contact your administrator');
        }
    },


    /**
     * onControllerFailure
     *
     * @description Handles an error caused by a client to server request
     * @param response
     */
    onControllerFailure: function (response) {
        var errors = response.getError();
        if (errors) {
            if (errors[0] && errors[0].message) {
                this.showToast('error', 'Server error', errors[0].message);
            }
        }
        else {
            this.showToast('error', 'Server error', 'Unknown');
        }
    },


    /**
     * onFetchTeamMemberRolesSuccess
     *
     * @description Sends the list with member roles to the UI including a 'Select a Role' value
     * @param response
     * @param component
     */
    onFetchTeamMemberRolesSuccess: function (response, component) {
        var data = response.getReturnValue();
        data.push({label: "-- Select a Role --", value: "", selected: "true"});
        component.find("InputMemberRole").set("v.options", data);
    },


    /**
     * openModal
     *
     * @description Active modal in the User Interface
     * @param component
     */
    openModal: function (component) {
        $A.util.addClass(component.find('Modalbox'), 'slds-fade-in-open');
        $A.util.addClass(component.find('Modalbackdrop'), 'slds-backdrop_open');
    },


    /**
     * showToast
     *
     * @description Show a Toast a the top of the users screen
     * @param type Toast type; error, success, warning
     * @param title The Toast title
     * @param message The Toast message
     */
    showToast: function (type, title, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            "message": message
        });
        toastEvent.fire();
    },


    /**
     * validateForm
     *
     * @description validates the form fields and activated the 'Add Member' button when all is O.K.
     * @param component
     */
    validateForm: function (component) {
        var userId = component.get('v.memberId');
        var roleId = component.get('v.memberRoleId');
        if (
            (null != userId && userId != '') &&
            (null != roleId && roleId != '')) {
            this.enableOkButton(component);
        }
        else {
            this.disableOkButton(component);
        }
    }
})