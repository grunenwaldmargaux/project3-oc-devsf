import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';
import { refreshApex } from '@salesforce/apex';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track error = null;
    wiredOpportunitiesResult; // Stocke la réponse du `@wire`

    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result; // Stocke la réponse pour `refreshApex`
        const { data, error } = result;

        if (data) {
            if (data.length === 0) {  
                this.error = 'Aucune opportunité trouvée pour ce compte.';
                this.opportunities = undefined;
            } else {
                this.opportunities = data;
                this.error = null;
            }
        } else if (error) {
            this.error = 'Une erreur s’est produite lors du chargement des opportunités.';
            this.opportunities = undefined;
        }
    }

    handleRafraichir() {
        refreshApex(this.wiredOpportunitiesResult); //  Rafraîchit les données sans recharger la page
    }
}
