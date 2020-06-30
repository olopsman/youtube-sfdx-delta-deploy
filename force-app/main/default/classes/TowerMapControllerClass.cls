public with sharing class TowerMapControllerClass {
     @AuraEnabled
     public static List<Tower__c> getAllTowers() {
          String theObject = 'Tower__c';
          List<String> theFields = new List<String>{'Id', 'Name', 'State__r.Name', 'Tower_Location__Latitude__s', 'Tower_Location__Longitude__s'};
          List<String> theFilters = new List<String>();  //empty filter list
          String sortField = 'Name';
          String sortOrder = 'ASC';
          List<Tower__c> allTowers = UtilityClass.queryObjects(theObject, theFields, theFilters, sortField, sortOrder);
          return allTowers;
     }
}