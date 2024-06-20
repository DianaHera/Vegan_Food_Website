class Produs{

    constructor({id, nume, descriere, pret, gramaj, tip_aliment, calorii, categorie, ingrediente, pt_diabetici, imagine, data_adaugare}={}) {

        for(let prop in arguments[0]){
            this[prop]=arguments[0][prop]
        }

    }

}