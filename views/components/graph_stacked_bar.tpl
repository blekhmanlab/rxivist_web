% import helpers
<script>
function getColor(cat, highlight) {
  if(cat == highlight) return '#468847'
  return 'rgba(186,186,186,0.5)'
}

Chart.Tooltip.positioners.custom = function(elements, eventPosition) {
    /** @type {Chart.Tooltip} */
    var tooltip = this;
    return {x: 10, y: 0};
}

function drawGraph(highlight) {
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
            backgroundColor: getColor("{{ dset['label'] }}", highlight),
            borderColor: getColor("{{ dset['label'] }}", highlight),
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
        position: 'custom',
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
drawGraph("bioinformatics");


</script>
<strong>Highlight a category:</strong><br>
% for i, dset in enumerate(traffic):
  <button class='btn btn-outline-secondary btn-sm' onclick='drawGraph("{{ dset['label'] }}")'>{{ helpers.formatCategory(dset['label']) }}</button>
% end