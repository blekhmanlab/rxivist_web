% import helpers
<script>
function getColor(repo) {
  if(repo=='biorxiv') return '#c52538';
  if(repo == 'medrxiv') return '#034d8f'
  return 'rgba(186,186,186,0.5)'
}

function drawGraph() {
  var ctx = document.getElementById("{{canvasID}}").getContext('2d');
  var chart = new Chart(ctx, {
    type: '{{ 'bar' if stacked else 'line' }}',
    data: {
      labels: [
        % for entry in traffic[0]['data']:
          "{{ entry["month"] }}/{{ entry["year"] }}",
        % end
      ],
      datasets: [
        % for i, dset in enumerate(traffic):
          {
            label: "{{ helpers.formatCategory(dset['label']) }}",
            backgroundColor: getColor("{{ dset['label'] }}"),
            borderColor: getColor("{{ dset['label'] }}"),
            pointStyle: 'cross',
            data: [
              % for entry in dset['data']:
                {{ entry["count"] }},
              % end
            ],
            fill: {{ 'true' if stacked else 'false' }},
            /* steppedLine: {{ 'false' if stacked else 'true' }}, */
          },
        % end
      ]
    },
    options: {
      legend: {
        display: false
      },
      tooltips: {
        mode: 'index',
        intersect: false,
        caretSize: 0,
        callbacks: {
          label: function(tooltipItem, data) {
            var label = data.datasets[tooltipItem.datasetIndex].label || '';
            if (label) label += ': ';
            label += tooltipItem.yLabel.toString().split(/(?=(?:...)*$)/).join(',')
            return label;
          }
        }
      },
      responsive: true,
      scales: {
        xAxes: [{
          stacked: {{ 'true' if stacked else 'false' }},
          scaleLabel: {
            display: true,
            labelString: 'Month'
          },
        }],
        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: '{{yaxis}}'
          },
          stacked: {{ 'true' if stacked else 'false' }},
          ticks: {
            userCallback: function(value, index, values) {
              return value.toString().split(/(?=(?:...)*$)/).join(',')
            }
          }
        }]
      }
    }
  });
}
drawGraph();


</script>
