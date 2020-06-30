trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> taskList = new List<Task>();
    for(Order_Event__e event : Trigger.new) {
        if(event.Has_Shipped__c == true) {
            Task tsk = new Task();
            tsk.Priority = 'Medium';
            tsk.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            tsk.OwnerId = event.CreatedById;
            taskList.add(tsk);
        }
    }
    
    if(taskList.size() > 0)
        insert taskList;

}