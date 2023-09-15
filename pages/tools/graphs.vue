<script setup lang="ts">
import type { Marathon } from '@/models/api';
const query = gql`
query {
    marathons {
        id
        color
        slug
        total
        start_date
        donationsTime {
            hour
            total
        }
    }
}
`
const marathons: Ref<Marathon[]> = ref<Marathon[]>([])
const datacollectionTotals: Ref<Object> = ref<Object>({})
const datacollectionOvertime: Ref<Object> = ref<Object>({})
type RespondData = {
    marathons: Marathon[]
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.marathons) {
    const marathonsRaw = data.value.marathons.sort((a, b) => (new Date(a.start_date).getTime()) - (new Date(b.start_date).getTime()))
    marathons.value = marathonsRaw
    const labels = marathonsRaw.map((marathon) => { return marathon.slug })
    const totalsData = marathonsRaw.map((marathon) => { return marathon.total })
    const backgroundColor = marathonsRaw.map((marathon) => { return '#' + marathon.color })
    // Create a dataset for each type of event (marathon.type)
    datacollectionTotals.value = {
        labels,
        datasets: [{
            label: 'Events',
            data: totalsData,
            backgroundColor
        }]
    }
    const longestMarathon = 180
      const marathonsWithData = marathonsRaw.filter((marathon) => {
        return (marathon.donationsTime.length > 0)
      })
      const datasets = marathonsWithData.map((marathon) => {
        return {
          label: marathon.slug,
          data: marathon.donationsTime.filter((entry) => { return (parseFloat(entry.hour) % 4 === 0) }).map((entry) => { return entry.total }),
          backgroundColor: '#' + marathon.color,
          borderColor: '#' + marathon.color,
          showLine: true,
          fill: false
        }
      })
      datacollectionOvertime.value = {
        labels: makeLabelsTo(longestMarathon),
        datasets
      }
}
const optionsTotals = {
    plugins: {
        tooltips: {
            callbacks: {
                label: function (context: any) {
                    let label = ''
                    if (context.parsed.y !== null) {
                    label += new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(context.parsed.y)
                    }
                    return label
                }
            }
        },
        legend: {
            display: true,
            positon: 'bottom'
        },
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
            ticks: {
                autoSkip: false
            }
        }
    },
    responsive: true,
    maintainAspectRatio: false
}
function makeLabelsTo (val: number) {
    const out = []
    let next = 0
    while (next < val) {
    out.push(next)
    next += 4
    }
    return out
}
const optionsOvertime = {
    plugins: {
        title: {
            display: false,
            position: 'top',
            text: 'Donations Over Time'
        },
        legend: {
            display: true,
            positon: 'bottom'
        },
        tooltips: {
            callbacks: {
                title(context: any) {
                    return context[0].xLabel + ' Hours'
                },
                label(context: any, data: any) {
                    let label = data.datasets[context.datasetIndex].label + ': '
                    if (context.yLabel !== null) {
                        label += new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(context.yLabel)
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
            ticks: {
                beginAtZero: true,
                callback(value: string) {
                    return '$' + value
                }
            }
        },
        x: {
            ticks: {
                autoSkip: false,
                step: 4,
                callback(dataLabel: string, index: number) {
                    return index % 6 === 0 ? parseInt(dataLabel) * 4 : null
                }
            },
            title: {
                display: true,
                text: 'Hours'
            }
        }
    },
    elements: {
        point: {
            radius: 2,
            hoverRadius: 5
        }
    },
    responsive: true,
    maintainAspectRatio: false
}
const myStyles = { height: '450px' }
useSeoMeta({
  title: 'Graphs - Bokoblin',
})
useServerSeoMeta({
  description: `Graphs to compare marathon-to-marathon totals and donations over time.`,
  ogTitle: 'Graphs - Bokoblin',
  ogDescription: `Graphs to compare marathon-to-marathon totals and donations over time.`,
})
</script>
<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      Graphs
    </h1>
    <p class="text-center">
      Inspired by 0rganics' "Zeldathon Graphs" spreadsheet. Best viewed on desktop
    </p>
    <div>
      <h2 class="text-xl my-3 text-center font-bold">
        Donation Totals
      </h2>
      <div class="rounded border p-2 dark:bg-slate-800 dark:text-gray-300 dark:border-gray-600">
        <BarGraph
          v-if="marathons.length > 0"
          :data="datacollectionTotals"
          :options="optionsTotals"
          :height="200"
          :styles="myStyles"
          class="h-[450px] w-full"
        />
      </div>
      <h2 class="text-xl my-3 text-center font-bold">
        Totals over Time
      </h2>
      <p class="text-center mb-2">
        Displayed as 1 plot point every 4 hours. For half-hour precision visit individual marathon pages
      </p>
      <div class="rounded border p-2 dark:bg-slate-800 dark:text-gray-300 dark:border-gray-600 mb-2">
        <LineGraph
          :data="datacollectionOvertime"
          :options="optionsOvertime"
          :height="200"
          :styles="myStyles"
          class="h-[450px] w-full"
        />
      </div>
    </div>
  </div>
</template>