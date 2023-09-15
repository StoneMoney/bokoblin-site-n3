<script setup lang="ts">
import { Line as ChartLine } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, LineElement, CategoryScale, LinearScale, PointElement, Filler } from 'chart.js'
ChartJS.register(Title, Tooltip, Legend, LineElement, CategoryScale, LinearScale, PointElement, Filler)
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
          y:
              {
                beginAtZero: true
              }
        },
        responsive: true
      }
    }
  }
})
</script>
<template>
  <ChartLine
    :data="props.data"
    :options="props.options"
  />
</template>
