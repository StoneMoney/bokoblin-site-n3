<script setup lang="ts">
import { Bar as ChartBar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, Filler } from 'chart.js'
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, Filler)
const props = defineProps({
  data: {
    required: true,
    type: Object
  },
  options: {
    required: false,
    type: Object,
    default: () => {
        return {
            scales: {
            yAxes: [
                {
                ticks: {
                    beginAtZero: true
                }
                }
            ]
            },
            responsive: true
        }
    }
  }
})
</script>
<template>
  <ChartBar
    :data="props.data"
    :options="props.options"
  />
</template>
