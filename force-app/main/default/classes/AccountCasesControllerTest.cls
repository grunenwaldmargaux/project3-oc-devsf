@IsTest
private class AccountCasesControllerTest {

    // Variable pour stocker l'ID du compte test
    private static Id testAccountId;

    @TestSetup
    static void setupTestData() {
        // Création d'un compte test
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        testAccountId = testAccount.Id;

        // Création de cas 
        Case case1 = new Case(AccountId = testAccountId, Subject = 'Problème de connexion', Status = 'Open');
        Case case2 = new Case(AccountId = testAccountId, Subject = 'Erreur 404', Status = 'Closed');
        insert new List<Case>{case1, case2};
    }

    @IsTest
    static void testFindCasesBySubject_ValidData() {
        Test.startTest();
        List<Case> cases = AccountCasesController.findCasesBySubject(testAccountId, 'connexion');
        Test.stopTest();

        System.assertEquals(1, cases.size(), 'Un seul cas doit être retourné pour ce sujet.');
    }

    @IsTest
    static void testFindCasesBySubject_NoResults() {
        Test.startTest();
        List<Case> cases = AccountCasesController.findCasesBySubject(testAccountId, 'Inexistant');
        Test.stopTest();

        System.assertEquals(0, cases.size(), 'Aucun cas ne doit être retourné.');
    }

    @IsTest
    static void testFindCasesBySubject_EmptySubject() {
        Test.startTest();
        List<Case> cases = AccountCasesController.findCasesBySubject(testAccountId, '');
        Test.stopTest();

        System.assertEquals(0, cases.size(), 'Aucun cas ne doit être retourné si le sujet est vide.');
    }
}
