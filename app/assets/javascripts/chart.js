$(document).ready(
    function () {
        var ctx = document.getElementById("myChart");

        config = {
            type: 'line',
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                datasets: [{
                    label:'Clicks in the past year',
                    data: [12, 19, 3, 5, 2, 3],
                    fill: false,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255,99,132,1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    xAxes: [{
                        type: 'time',
                        time: {
                            unit: 'month'
                        },
                        ticks: {

                        }
                    }]
                },
                elements: {
                    line: {
                        tension: 0.1, // disables bezier curves
                    }
                }
            }
        };
        myChart = new Chart(ctx, config);
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
            $("#url").text("https://little.tw/" + jdata["redirect"]);
            $("#click_count").text(jdata["count"]);
            console.log(jdata["time"]);
            var timelabel = [];
            var timeDic = {};
            var clicks = [];
            for (i = 11; i >= 0; i--) {
                timelabel.push(moment().subtract(i, 'months').format('MMM YYYY'));
                timeDic[moment().subtract(i, 'months').format('MMM YYYY')] = 0;
            }
            console.log(timelabel);

            for (i in jdata["time"]) {
                if (moment(jdata["time"][i]).format('MMM YYYY') in timeDic) {
                    timeDic[moment(jdata["time"][i]).format('MMM YYYY')]++;
                }
            }
            for (i=0;i<12;i++){
                clicks[i] = timeDic[timelabel[i]];
            }
            console.log(timeDic);
            console.log(clicks);
            config.data.labels=timelabel;
            config.data.datasets[0].data = clicks;
            window.myChart.update();


        }
    };
    xhttp.open("GET", "/user/chartdata/" + id, true);
    xhttp.send();

}