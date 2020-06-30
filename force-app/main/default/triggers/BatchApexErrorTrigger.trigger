trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    List<BatchLeadConvertErrors__c> blList = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent b: trigger.new){
        BatchLeadConvertErrors__c bl = new BatchLeadConvertErrors__c();
        bl.AsyncApexJobId__c = b.AsyncApexJobId;
        bl.Records__c = b.JobScope;
        bl.StackTrace__c = b.StackTrace;
        blList.add(bl);
    }
    insert blList;
}