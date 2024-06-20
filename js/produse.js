window.addEventListener("load", function () {
    document.getElementById("filtrare").onclick = function () {
        var inpNume = document.getElementById("inp-nume").value.trim().toLowerCase();
        if (!validareNume(inpNume)) {
            alert("Numele nu poate conține cifre.");
            return;
        }

        var vRadio = document.getElementsByName("gr_rad");
        var inpCalorii;
        for (let r of vRadio) {
            if (r.checked) {
                inpCalorii = r.value;
                break;
            }
        }
        if (!inpCalorii) {
            alert("Selectați o opțiune pentru filtrarea după calorii.");
            return;
        }

        let minCalorii, maxCalorii;
        if (inpCalorii != "toate") {
            var aux = inpCalorii.split(":");
            minCalorii = parseInt(aux[0]);
            maxCalorii = parseInt(aux[1]);
        }

        var inpPretMin = parseInt(document.getElementById("inp-pret-min").value);
        var inpPretMax = parseInt(document.getElementById("inp-pret-max").value);
        if (isNaN(inpPretMin) || isNaN(inpPretMax) || inpPretMin > inpPretMax) {
            alert("Introduceți valori valide pentru intervalul de preț.");
            return;
        }

        var inpCateg = document.getElementById("inp-categorie").value.trim().toLowerCase();

        aplicareFiltrare(inpNume, inpCalorii, minCalorii, maxCalorii, inpPretMin, inpPretMax, inpCateg);
    }

    document.getElementById("resetare").onclick = function () {
        var confirmaResetare = confirm("Sigur doriți să resetați filtrele? Aceasta va anula și sortarea curentă.");
        if (confirmaResetare) {
            resetareFiltreSiSortare();
        }
    }

    document.getElementById("sortCrescNumeDescriere").onclick = function () {
        sortareProduse(1);
    }

    document.getElementById("sortDescrescNumeDescriere").onclick = function () {
        sortareProduse(-1);
    }

    document.getElementById("calculeazaSuma").onclick = function () {
        calculareSumaProduse();
    }

    window.addEventListener("keydown", function (e) {
        if (e.altKey && e.code === "KeyC") {
            calculareSumaProduseSelectate();
        }
    });

    function validareNume(nume) {
        return !/\d/.test(nume);
    }

    function aplicareFiltrare(nume, calorii, minCal, maxCal, minPret, maxPret, categorie) {
        var produse = document.getElementsByClassName("produs");

        for (let produs of produse) {
            let valNume = produs.getElementsByClassName("val-nume")[0].innerHTML.trim().toLowerCase();

            let cond1;
            if (nume.includes('*')) {
                const [start, end] = nume.split('*');
                cond1 = valNume.startsWith(start) && valNume.endsWith(end);
            } else {
                cond1 = valNume.includes(nume);
            }

            let valCalorii = parseInt(produs.getElementsByClassName("val-calorii")[0].innerHTML);
            let cond2 = (calorii == "toate" || (minCal <= valCalorii && valCalorii < maxCal));

            let valPret = parseInt(produs.getElementsByClassName("val-pret")[0].innerHTML);
            let cond3 = valPret >= minPret && valPret <= maxPret;

            let valCategorie = produs.getElementsByClassName("val-categorie")[0].innerHTML.trim().toLowerCase();
            let cond4 = categorie == "toate" || categorie == valCategorie;

            if (cond1 && cond2 && cond3 && cond4) {
                produs.style.display = "block";
            } else {
                produs.style.display = "none";
            }
        }
    }

    function resetareFiltreSiSortare() {
        document.getElementById("inp-nume").value = "";

        document.getElementById("inp-pret-min").value = document.getElementById("inp-pret-min").min;
        document.getElementById("inp-pret-max").value = document.getElementById("inp-pret-max").max;
        document.getElementById("inp-categorie").value = "toate";
        document.getElementById("i_rad4").checked = true;
        var produse = document.getElementsByClassName("produs");

        for (let prod of produse) {
            prod.style.display = "block";
        }

        // Resetare sortare
        var gridProduse = document.querySelector('.grid-produse');
        var produseSortate = Array.from(produse);
        produseSortate.sort(function (a, b) {
            return a.dataset.originalIndex - b.dataset.originalIndex;
        });
        produseSortate.forEach(function (prod) {
            gridProduse.appendChild(prod);
        });
    }

    function sortareProduse(semn) {
        var produse = document.getElementsByClassName("produs");
        let v_produse = Array.from(produse);
        v_produse.sort(function (a, b) {
            let nume_a = a.getElementsByClassName("val-nume")[0].innerHTML.toLowerCase();
            let nume_b = b.getElementsByClassName("val-nume")[0].innerHTML.toLowerCase();
            if (nume_a == nume_b) {
                let descriere_a = a.getElementsByClassName("val-descriere")[0].innerHTML.length;
                let descriere_b = b.getElementsByClassName("val-descriere")[0].innerHTML.length;
                return semn * (descriere_a - descriere_b);
            }
            return semn * nume_a.localeCompare(nume_b);
        });
        for (let prod of v_produse) {
            prod.parentNode.appendChild(prod);
        }
    }

    function calculareSumaProduse() {
        var produse = document.getElementsByClassName("produs");
        let suma = 0;
        for (let prod of produse) {
            if (prod.style.display != "none") {
                suma += parseFloat(prod.getElementsByClassName("val-pret")[0].innerHTML);
            }
        }
        var div = document.createElement("div");
        div.innerHTML = `Suma preturilor produselor vizibile este ${suma} lei`;
        div.style.position = "fixed";
        div.style.bottom = "10px";
        div.style.right = "10px";
        div.style.padding = "10px";
        div.style.backgroundColor = "rgba(0, 0, 0, 0.8)";
        div.style.color = "white";
        div.style.borderRadius = "5px";
        document.body.appendChild(div);

        setTimeout(function () {
            document.body.removeChild(div);
        }, 2000);
    }

    function calculareSumaProduseSelectate() {
        var produse = document.getElementsByClassName("produs");
        let suma = 0;
        for (let prod of produse) {
            let checkbox = prod.getElementsByClassName("select-cos")[0];
            if (checkbox.checked && prod.style.display != "none") {
                suma += parseFloat(prod.getElementsByClassName("val-pret")[0].innerHTML);
            }
        }
        alert("Suma preturilor produselor selectate este " + suma + " lei");
    }
});
