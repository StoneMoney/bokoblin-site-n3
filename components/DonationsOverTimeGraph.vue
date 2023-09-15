<script setup lang="ts">
import type { DonationsOverTime, Marathon } from '@/models/api'
const props = defineProps({
  data: {
    required: true,
    type: Object as PropType<Marathon>
  }
})
const datacollection = ref({})
const options = ref({})
function fillData () {
  options.value = {
    plugins: {
      title: {
        display: false,
        position: 'top',
        text: 'Donations Over Time'
      },
      legend: {
        display: false
      },
      tooltip: {
        callbacks: {
          title: function (context: any) {
            return context[0].raw.x + ' Hours'
          },
          label: function (context: any) {
            let label = ''
            if (context.parsed.y !== null) {
              label += new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(context.parsed.y)
            }
            return label
          }
        }
      }
    },
    scales: {
      y: {
        title: {
          display: true,
          text: 'Raised'
        },
        beginAtZero: true,
        ticks: {
          callback: function (value: any) {
            return toUSD(value, false)
          }
        }
      },
      x: {
        title: {
          display: true,
          text: 'Hours'
        },
        ticks: {
          autoSkip: false,
          stepSize: 0.5,
          callback: function (value: any, index: number) {
            return index % 24 === 0 ? (value / 2) : null
          }
        }
      }
    },
    elements: {
      line: {
        borderColor: '#' + props.data.color,
        borderWidth: 3
      },
      point: {
        radius: 2,
        hoverRadius: 5,
        backgroundColor: 'rgba(0,0,0,0)'
      }
    },
    responsive: true,
    maintainAspectRatio: true
  }
  const processedData = props.data.donationsTime.map((entry: DonationsOverTime) => { return { x: Number(parseFloat(entry.hour).toFixed(2)), y: Number(entry.total.toFixed(2)) } })
  datacollection.value = {
    labels: makeLabelsTo((processedData.length) / 2),
    datasets: [
      {
        label: props.data.full_name,
        fill: true,
        backgroundColor: hex2rgb(props.data.color),
        data: processedData
      }
    ]
  }
}
function hex2rgb (colour: string): string {
  let r, g, b
  if (colour.charAt(0) === '#') {
    colour = colour.substr(1)
  }
  if (colour.length === 3) {
    colour = colour.substr(0, 1) + colour.substr(0, 1) + colour.substr(1, 2) + colour.substr(1, 2) + colour.substr(2, 3) + colour.substr(2, 3)
  }
  r = colour.charAt(0) + '' + colour.charAt(1)
  g = colour.charAt(2) + '' + colour.charAt(3)
  b = colour.charAt(4) + '' + colour.charAt(5)
  r = parseInt(r, 16)
  g = parseInt(g, 16)
  b = parseInt(b, 16)
  return 'rgba(' + r + ',' + g + ',' + b + ',0.5)'
}
function makeLabelsTo (val: number): number[] {
  const out = []
  let next = 0
  while (next < val) {
    out.push(next)
    next += 0.5
  }
  return out
}
fillData()
</script>
<template>
  <LineGraph
    :data="datacollection"
    :options="options"
    class="max-h-72 w-full"
  />
</template>
<style scoped>
  .chart-container {
    height: 300px;
    position: 'relative'
  }
</style>
