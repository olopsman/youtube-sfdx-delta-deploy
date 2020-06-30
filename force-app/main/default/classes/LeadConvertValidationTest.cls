@isTest
private class LeadConvertValidationTest {

    private static final String CONVERTED_STATUS = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1].MasterLabel;

    @isTest
    static void validateDoNotConvert(){
        Lead l = new Lead(LastName = 'Johnson DoNOTConvert', FirstName = 'John', Company = 'Salesforce');
        insert l;

        Test.startTest();
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(l.Id);
            lc.setConvertedStatus(CONVERTED_STATUS);
            Database.LeadConvertResult res = Database.convertLead(lc, false);
        Test.stopTest();

        System.assert(res.getErrors().size() > 0, 'Expected error converting a lead with DoNotConvert in the last name');
    }

    @isTest
    static void validateAllowedConvert(){
        Lead l = new Lead(LastName = 'Johnson', FirstName = 'John', Company = 'Salesforce');
        insert l;

        Test.startTest();
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(l.Id);
            lc.setConvertedStatus(CONVERTED_STATUS);
            Database.convertLead(lc, true); //exception here will fail the test
        Test.stopTest();
    }
}