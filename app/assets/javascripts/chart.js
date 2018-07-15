$(document).ready(
    function () {
        var ctx = document.getElementById("myChart");
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',

                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',

                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    }
);


function getchart(id) {
    console.log(id);
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            jdata = JSON.parse(this.response);
            console.log(jdata);
            console.log($("#chartModalTitle"));
            $("#url").text("http://little.tw/" + jdata["redirect"]);
            $("#click_count").text(jdata["count"]);
            console.log(jdata["count"]);

        }
    };
    xhttp.open("GET", "/user/chartdata/" + id, true);
    xhttp.send();

}