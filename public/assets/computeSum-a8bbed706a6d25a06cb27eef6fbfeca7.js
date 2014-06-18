$(document).ready(function () {
    var table = $("tbody");

    var shopy = new Array(7);
    for (var i = shopy.length - 1; i >= 0; --i) shopy[i] = 0;

    table.find('tr').each(function (i) {
        var $tds = $(this).find('td');
        for (var j = 0; j < 7; j++) {
            temp = parseFloat($tds.eq(j).text());

            if (!isNaN(temp)) {
                shopy[j] += temp;
            }
        }
    });
    shopy[1] = "Celková suma (€): ";

    var prices = document.getElementById("ceny");
    var cells = new Array(7);
    var sumRow = prices.insertRow(-1);
    sumRow.className = 'well';
    for (var j = 0; j < 7; j++) {
        cells[j] = sumRow.insertCell(j);
        if(j==0) cells[j].innerHTML = shopy[j] + " ks";
        else if(j==1) cells[j].innerHTML = shopy[j];
        else cells[j].innerHTML = shopy[j].toFixed(2);

        cells[j].style.fontWeight = 'bold';
    }

    var min=9999999;
    var max=0;
    var minID, maxID;
    for (var j = 2; j < 7; j++) {
        if (shopy[j]>max){
            max = shopy[j];
            maxID = j;
        }
        else if(shopy[j] == max){
            maxID=null;
        }
    }
    for (var j = 2; j < 7; j++) {
        if (shopy[j] < min){
            min = shopy[j];
            minID = j;
        }
        else if(shopy[j] == min){
            minID=null;
        }
    }
    if(minID != null)
        cells[minID].style.backgroundColor = 'green';
    if(maxID != null)
        cells[maxID].style.backgroundColor = 'red';
});
