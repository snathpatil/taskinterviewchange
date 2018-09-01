public class TaskSwitchController implements AuraInterface{
	@AuraEnabled
    public static List<TaskActionWrapper> getTasks(){
        List<TaskActionWrapper> vListToReturn = new List<TaskActionWrapper>();
        Integer i=0;
        for(Task vTaskItem : [SELECT Id, Subject, Status FROM Task LIMIT 100]){
            TaskActionWrapper vTemp = new TaskActionWrapper();
            vTemp.vTask = vTaskItem;
            vTemp.vIndex = i;
            vListToReturn.add(vTemp);
            i++;
        }
        return vListToReturn;
    }
    
    @AuraEnabled
    public static Boolean updateTask(String pTaskJSON){
        System.debug('THE WRAPPER -->'+pTaskJSON);
        TaskSwitchController.TaskActionWrapper vWrapper = (TaskSwitchController.TaskActionWrapper)JSON.deserialize(pTaskJSON, TaskSwitchController.TaskActionWrapper.class);
        Task vTask = vWrapper.vTask;
        System.debug('THE TASK -->'+vTask);
        vTask.Status = (vTask.Status == 'In Progress')?'Not Started':'In Progress';
        try{
        	UPDATE vTask;    
        }catch(Exception e){
            System.debug('THE EXCEPTION -->'+e);
            return false;
        }
        return true;
    }
    
    class TaskActionWrapper{
        @AuraEnabled
        public Task vTask{get;set;}
        @AuraEnabled
        public Integer vIndex{get;set;}
        @AuraEnabled
        public Boolean vChecked{get;set;}
        public TaskActionWrapper(){
            vTask = new Task();
            vIndex = 0;
            vChecked = false;
        }
    }
}