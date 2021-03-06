<script>
var ctx = document.getElementById("{{canvasID}}").getContext('2d');
var chart = new Chart(ctx, {
  // The type of chart we want to create
  type: 'line',

  // The data for our dataset
  data: {
    labels: [
      % for entry in traffic:
        "{{ entry["month"] }}/{{ entry["year"] }}",
      % end
    ],
    datasets: [{
      label: "{{yaxis}}",
      backgroundColor: 'rgba(70,136,71, 0.5)',
      borderColor: '#468847',
      data: [
        % for entry in traffic:
          {{ entry["count"] }},
        % end
      ]
    }]
  },
  options: {
    legend: {
      display: false
    },
    scales: {
      yAxes: [{
        display: true,
        position: 'left',
        scaleLabel: {
          display: true,
          labelString: '{{yaxis}}'
        },
        ticks: {
          userCallback: function(value, index, values) {
            return value.toString().split(/(?=(?:...)*$)/).join(',')
          }
        }
      }],
      xAxes: [{
        scaleLabel: {
          display: true,
          labelString: 'Month'
        }
      }]
    },
    tooltips: {
      callbacks: {
        label: function(tooltipItem, data) {
          var label = data.datasets[tooltipItem.datasetIndex].label || '';
          if (label) label += ': ';
          label += tooltipItem.yLabel.toString().split(/(?=(?:...)*$)/).join(',')
          return label;
        }
      }
    }
  }
});
</script>