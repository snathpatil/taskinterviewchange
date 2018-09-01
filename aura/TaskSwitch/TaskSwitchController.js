({
	myAction : function(component, event, helper) {
		var action = component.get("c.getTasks");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
                var returnVal = action.getReturnValue();
                //console.log('the retval -->'+JSON.stringyfy(returnVal));
                component.set("v.TasksWrapList", returnVal);
            }
        });
        $A.enqueueAction(action);
	},
    handleInputCheckboxChange : function(component, event, helper){
    	var checkbox = event.getSource().get("v.value");
        var checkIndex = checkbox.vIndex;
       
        var action = component.get("c.updateTask");
        action.setParams({ 
            pTaskJSON : JSON.stringify(checkbox)
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
                var returnVal = action.getReturnValue();
                if(returnVal){
                    var TaskListLoop = component.get("v.TasksWrapList");
                    TaskListLoop[checkIndex].vTask.Status = (TaskListLoop[checkIndex].vTask.Status == 'In Progress')?'Not Started':'In Progress';
                    component.set("v.TasksWrapList", TaskListLoop);
                }
            }
        });
        $A.enqueueAction(action);
	}
})