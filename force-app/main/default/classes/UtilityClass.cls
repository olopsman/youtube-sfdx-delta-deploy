public inherited sharing class UtilityClass {

     // SFDX youtube tutorial - enabled auto deploy -- edited online

     public static List<sObject> queryObjects(String theObject, List<String> theFields, List<String> theFilters, String sortField, String sortOrder) {
          String theQuery = 'SELECT ' + string.join(theFields, ',');
          theQuery += ' FROM ' + theObject;
          boolean firstFilter = true;
          if(!String.isEmpty(sortField)) {
               theQuery += ' ORDER BY ' + sortField;
               if(!String.isEmpty(sortOrder)) {
                    theQuery += ' ' + sortOrder;
               }
          }
          String theQueryResult = string.escapeSingleQuotes(theQuery);  //escapes the string
          return database.query(theQueryResult);
     }
}