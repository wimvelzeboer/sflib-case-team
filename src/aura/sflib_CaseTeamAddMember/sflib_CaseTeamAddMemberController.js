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