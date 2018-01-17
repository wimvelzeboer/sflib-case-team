({

    checkRecordAccess: function (component)
    {
        var action = component.get("c.isUpdateable");
        action.setParams({
            caseRecordId: component.get("v.recordId")
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.onCheckRecordAccessSuccess(response, component);
            }
            else if (state === "ERROR") {
                this.onControllerFailure(response)
            }
        });
        $A.enqueueAction(action);

    },


    /**
     * fetchData
     *
     * @description Send a request to the server to retrieve the Case Team details
     * @param component
     */
    fetchData: function(component)
    {
        var action = component.get("c.getCaseTeamData");
        action.setParams({
            caseRecordId: component.get("v.recordId")
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.onFetchSuccess(response, component);
            }
            else if (state === "ERROR") {
                this.onControllerFailure(response)
            }
        });
        $A.enqueueAction(action);
    },


    /**
     * initColumns
     *
     * @description Initialises the dataTable columns
     * @param component
     */
    initColumns: function (component) {
        component.set('v.tableColumns',
            [
                {label: 'Team Member', fieldName: 'MemberName', type: 'text'},
                {label: 'Member Role', fieldName: 'RoleName', type: 'text'},
                {label: 'Case Access', fieldName: 'AccessType', type: 'text'},
                {label: 'Modified By', fieldName: 'LastModifiedBy', type: 'text'}
            ]);
    },


    onCheckRecordAccessSuccess: function (response, component) {
        component.set("v.hasWriteAccess", response.getReturnValue());
    },


    /**
     * onControllerFailure
     *
     * @description Handles an error caused by a client to server request
     * @param response
     */
    onControllerFailure: function(response)
    {
        var errors = response.getError();
        if (errors) {
            if (errors[0] && errors[0].message)
            {
                this.showToast('error','Server error', errors[0].message);
            }
        }
        else
        {
            this.showToast('error','Server error', 'Unknown');
        }
    },


    /**
     * onFieldDataLoadSucces
     *
     * @description Send updated data to user interface
     * @param response from server
     * @param component
     */
    onFetchSuccess: function(response, component)
    {
        component.set("v.caseTeamData", response.getReturnValue());
    },


    /**
     * onMemberRemovalSuccess
     *
     * @description Show success message and fetch the updated Case Team List
     * @param response
     * @param component
     */
    onMemberRemovalSuccess: function (response, component)
    {
        this.showToast('success','SUCCESS','Case team member removed');
        this.fetchData(component);
        component.set("v.selectedMemberIds", []);
    },


    /**
     * removeSelectedMembers
     *
     * @description Sends a request to the server for removal of Case Team members
     * @param component
     * @param selectedMembers
     */
    removeSelectedMembers: function (component, selectedMembers)
    {
        var action = component.get("c.removeCaseTeamMembers");
        action.setParams({
            caseTeamMemberIds: selectedMembers
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.onMemberRemovalSuccess(response, component);
            }
            else if (state === "ERROR") {
                this.onControllerFailure(response)
            }
        });
        $A.enqueueAction(action);
    },


    /**
     * showToast
     *
     * @description Show a Toast a the top of the users screen
     * @param type Toast type; error, success, warning
     * @param title The Toast title
     * @param message The Toast message
     */
    showToast : function(type, title, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            "message": message
        });
        toastEvent.fire();
    }
})