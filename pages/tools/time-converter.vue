<script setup lang="ts">
import type { Marathon } from '@/models/api'
const query = gql`
  query {
    marathons {
        id
        full_name
        color
        type
        start_date
        stop_date
    }
  }
  `
const marathons: Ref<Marathon[]> = ref<Marathon[]>([])
const selected: Ref<Marathon | undefined> = ref(undefined)
const timestamp: Ref<string> = ref('00:00:00')
type RespondData = {
    marathons: Marathon[]
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.marathons) {
  marathons.value = [...data.value.marathons].sort((a, b) => {
    return (new Date(b.start_date)).getTime() - new Date(a.start_date).getTime()
  })
  selected.value = marathons.value[0]
}
function getTimeOut (input: string, selected: Marathon) {
    if (input && selected) {
        const times = input.split(':')
        if (times.length === 3) {
            const start = new Date(selected.start_date)
            start.setHours(start.getHours() + parseInt(times[0]))
            start.setMinutes(start.getMinutes() + parseInt(times[1]))
            start.setSeconds(start.getSeconds() + parseInt(times[2]))
            return start.toLocaleString()
        }
        if (times.length === 2) {
            const start = new Date(selected.start_date)
            start.setMinutes(start.getMinutes() + parseInt(times[0]))
            start.setSeconds(start.getSeconds() + parseInt(times[1]))
            return start.toLocaleString()
        }
        if (times.length === 1) {
            const start = new Date(selected.start_date)
            start.setSeconds(start.getSeconds() + parseInt(times[0]))
            return start.toLocaleString()
        }
    }
    return 'Invalid Format'
}
watch(selected,()=>{
})
watch(timestamp,()=>{
})
useSeoMeta({
  title: 'Time Converter - Bokoblin',
})
useServerSeoMeta({
  description: `Turn marathon timestamps into real-life dates.`,
  ogTitle: 'Time Converter - Bokoblin',
  ogDescription: `Turn marathon timestamps into real-life dates.`,
})
</script>
<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      Marathon Time Conversion Tool
    </h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
      <div
        class="flex flex-col gap-2"
      >
        <fieldset>
          <legend class="text-base font-semibold text-gray-900 dark:text-white">
            Select an event
          </legend>
          <div class="mt-4 divide-y divide-gray-200 dark:divide-gray-700 border-b border-t border-gray-200 dark:border-gray-600 h-[60vh] overflow-y-auto">
            <div
              v-for="(marathon, mIndex) in marathons"
              :key="mIndex"
              class="relative flex items-start py-4"
            >
              <div class="min-w-0 flex-1 text-sm leading-6">
                <label
                  :for="`m-${marathon.id}`"
                  class="select-none font-medium text-gray-900 dark:text-gray-100"
                >{{ marathon.full_name }}</label>
              </div>
              <div class="mx-3 flex h-6 items-center">
                <input
                  :id="`m-${marathon.id}`"
                  v-model="selected"
                  name="plan"
                  type="radio"
                  :value="marathon"
                  :checked="marathon.id === null"
                  :class="`h-4 w-4 border-gray-300 dark:border-gray-600 focus:ring-green-600`"
                  :style="`color: #${marathon.color};`"
                >
              </div>
            </div>
          </div>
        </fieldset>
      </div>
      <div>
        <h1><b>Selected:</b> {{ selected?.full_name ?? "NONE" }}</h1>
        <h3 v-if="selected">
          <b>Started:</b> {{ new Date(selected.start_date).toLocaleString() }}
        </h3>
        <h3 v-else>
          No selection
        </h3>
        <div>
          <label
            for="in"
            class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-100"
          >
            Timestamp
          </label>
          <div class="mt-2">
            <input
              id="in"
              v-model="timestamp"
              type="text"
              name="in"
              class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-gray-100 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 dark:bg-black"
              placeholder="00:00:00"
            >
          </div>
        </div>
        <div>
          <label
            for="in"
            class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-100"
          >
            Date
          </label>
          <div class="mt-2">
            <input
              id="out"
              disabled
              type="text"
              name="out"
              class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-gray-100 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 dark:bg-black"
              placeholder="12/31/1969 4:00:00 PM"
              :value="selected ? getTimeOut(timestamp, selected) : ''"
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
