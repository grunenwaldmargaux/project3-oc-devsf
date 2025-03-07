**📌 Salesforce Project 3 - OpenClassrooms**

🚀 Introduction

Ce projet vise à améliorer une interface utilisateur sur Salesforce en utilisant Lightning Web Components (LWC) et à mettre en place une recherche avancée via Apex. L'objectif était d'améliorer l'affichage et la gestion des données tout en garantissant une meilleure expérience utilisateur.

**📂 Contenu du projet**

**🏗 1. Amélioration de l’interface avec un Lightning Web Component (LWC)**

Développement d’un LWC interactif pour afficher et gérer les opportunités d’un compte Salesforce.

Mise en place d’une gestion dynamique des erreurs et d’un rafraîchissement des données sans rechargement de la page.

🔧 Corrections et améliorations

Correction de l’annotation @wire pour rendre le composant réactif.

Fermeture correcte de la classe JavaScript pour éviter les erreurs de compilation.

Gestion des opportunités vides avec affichage d’un message approprié.

Stockage et affichage dynamique des erreurs pour améliorer la clarté de l’interface.

Ajout de refreshApex() pour mettre à jour les données sans recharger la page.

🎯 Résultat final

✅ Les opportunités s'affichent correctement.
✅ Le message d’erreur est dynamique et s'affiche en fonction des cas d'erreurs.
✅ Le bouton "Rafraîchir" met bien à jour les opportunités sans recharger la page.

**🔍 2. Recherche de données via Apex**

Développement d’une classe Apex permettant de rechercher des cas (cases) associés à un compte en fonction d’un terme de recherche sur le sujet.

🖥️ Code Apex implémenté

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

🔧 Fonctionnalités et améliorations

Vérification sécurisée des entrées pour éviter les erreurs.

Utilisation de LIKE avec wildcards (%) pour permettre une recherche flexible.

Ajout de logs (System.debug) pour faciliter le débogage et le suivi des requêtes.

🎯 Résultat final

✅ Recherche performante et filtrée des cas.
✅ Retourne uniquement les résultats pertinents en fonction du compte et du sujet recherché.
✅ Code robuste et optimisé avec un suivi facilité.

🎓 Compétences démontrées

✅ Développement et optimisation de Lightning Web Components (LWC).

✅ Manipulation avancée d’Apex et SOQL pour la gestion des données.

✅ Amélioration de l’expérience utilisateur dans Salesforce.

✅ Implémentation de bonnes pratiques en gestion d'erreurs et rafraîchissement de données.
