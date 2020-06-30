@isTest
public class QuickTester {
    @testSetup
    static void dataSetup(){
        Account acc = new Account();
        acc.Name = 'bar';
        acc.BillingCity = '525 S. Lexington Ave';
        acc.BillingState = 'NC';
        acc.BillingPostalCode = '27215';
        acc.BillingCountry = 'USA';
        insert acc;
        
        
        Tower__c tower = new Tower__C();
        tower.Name = 'foo';
        tower.State__c = acc.id;
        insert tower;
    }
    
    @isTest
    static void testTowerAura(){
    	TowerMapControllerClass.getAllTowers();
    }
    
    
    @isTest
    static void testEvents(){
        List<Order_Event__e> ordList = new List<Order_Event__e>();
        Order_Event__e ord = new Order_Event__e();
        ord.Has_Shipped__c = true;
        ord.Order_Number__c  = '10';  
        ordList.add(ord);
        Test.startTest();
        List<Database.SaveResult> results = EventBus.publish(ordList);
        Test.stopTest();

        
    }
}