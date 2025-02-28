public with sharing class AccountCasesController {

    @AuraEnabled
    public static List<Case> findCasesBySubject(String accountId, String subjectSearchTerm) {
        System.debug('#accountId: ' + accountId);
        System.debug('#subjectSearchTerm: ' + subjectSearchTerm);
        
        List<Case> cases = new List<Case>();
        
        if (accountId != null && subjectSearchTerm != null && subjectSearchTerm != '') {
            String searchPattern = '%' + subjectSearchTerm + '%'; // Ajout des wildcards pour le LIKE
            cases = [
                SELECT Id, CaseNumber, Subject, Status, Priority, CreatedDate 
                FROM Case 
                WHERE AccountId = :accountId 
                AND Subject LIKE :searchPattern
            ];
            System.debug('#Cases trouvés: ' + cases);
        }
        return cases;
    }
}
