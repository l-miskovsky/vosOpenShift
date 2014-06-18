$(document).ready(function () {
    var table = $("tbody");

    var shopy = new Array(6);
    for (var i = shopy.length - 1; i >= 0; --i) shopy[i] = 0;
    shopy[0] = "Celková suma (€): ";
    table.find('tr').each(function (i) {
        var $tds = $(this).find('td');
        for (var j = 1; j < 6; j++) {
            temp = parseFloat($tds.eq(j).text());

            if (!isNaN(temp)) {
                shopy[j] += temp;
            }
        }
    });

    var prices = document.getElementById("ceny");
    var cells = new Array(6);
    var sumRow = prices.insertRow(-1);
    for (var j = 0; j < 6; j++) {
        cells[j] = sumRow.insertCell(j);
        if(j!=0) cells[j].innerHTML = shopy[j].toFixed(2);
        else cells[j].innerHTML = shopy[j];
        cells[j].style.fontWeight = 'bold';
    }
});
