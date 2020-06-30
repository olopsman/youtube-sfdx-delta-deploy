@isTest
public class BatchLeadConvertTest {

    @isTest
    static void sanity(){
        Lead l = new Lead(
                FirstName = 'Bobby',
                LastName = 'Bobson',
                Company = 'Salesforce'
        );
        insert l;
        BatchLeadConvert job = new BatchLeadConvert();
        Test.startTest();
            Id jobId = Database.executeBatch(job);
        Test.stopTest();
        System.assertEquals(0, [SELECT NumberOfErrors FROM AsyncApexJob WHERE Id = :jobId].NumberOfErrors);
    }

    @isTest
    static void customObjectCreatedFromEventTrigger(){
        if(!isUpdatedForEvents()){
            return;
        }
        Lead errLead = new Lead(
                LastName = 'Astro DoNotConvert',
                Company = 'Trailhead'
        );
        insert errLead;

        BatchLeadConvert job = new BatchLeadConvert();
        Test.startTest();
            Id jobId = Database.executeBatch(job);
        try{
            Test.stopTest();
        }catch(DmlException ex){ /* don't fail this test if there were errors in the batch job - we want that */ }
        Test.getEventBus().deliver();

        List<BatchLeadConvertErrors__c> errorLogs = [SELECT id, StackTrace__c, Records__c FROM BatchLeadConvertErrors__c];
        System.assertEquals(1, errorLogs.size(), 'Expected errors converting DoNotConvertLeads');
        System.assert(errorLogs[0].Records__c.contains(errLead.Id), 'Expected "Astro DoNotConvert" Lead to fail to convert');
    }

    static Boolean isUpdatedForEvents(){
        ApexClass cls = [SELECT Body FROM ApexClass WHERE Name = 'BatchLeadConvert'];
        return cls.body.containsIgnoreCase('Database.RaisesPlatformEvents');
    }
}