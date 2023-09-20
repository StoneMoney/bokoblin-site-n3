<script setup lang="ts">
import type { Game } from '@/models/api'
const props = defineProps<{
    data: Game;
}>()
const total = props.data.segments?.reduce((a, b) => a + (b.raised ?? 0), 0)
const totalTimeInt = props.data.segments?.reduce((a, b) => a + (getDurationNumberal(b.start_time, b.end_time)), 0) ?? -1
const totalTime = totalTimeInt >= 0 ? toTimestamp(new Date(0),new Date(totalTimeInt * 3.6e+6)) : false
</script>
<template>
  <div class="border dark:border-gray-600 rounded-md group">
    <div
      class="bg-slate-50 group-hover:bg-slate-100 dark:bg-slate-800 group-hover:dark:bg-slate-700 shadow-sm rounded-md py-1 px-2 border-r-4 group-hover:border-r-8 transition-all grid grid-cols-2 sm:grid-cols-3"
    >
      <div class="flex flex-col gap-2 col-span-2 h-full justify-center">
        <nuxt-link :to="`/game/${props.data.id}`">
          <div class="text-2xl font-semibold">
            {{ props.data.title }}
          </div>
        </nuxt-link>
      </div>
      <div class="grid grid-cols-3 sm:flex sm:flex-col text-gray-400 sm:items-end sm:justify-around col-span-2 sm:col-span-1">
        <div
          v-if="total"
          class="flex items-center gap-1"
        >
          <Icon
            name="clarity:dollar-bill-solid"
            size="1.2rem"
          />
          {{ toUSD(total) }}
        </div>
        <div v-else>
          &nbsp;
        </div>
        <div
          v-if="totalTime"
          class="flex items-center gap-1"
        >
          <Icon
            name="bx:stopwatch"
            size="1.2rem"
          />
          {{ totalTime }}
        </div>
        <div v-else>
          &nbsp;
        </div>
        <div
          v-if="props.data.segments && props.data.segments.length > 0"
          class="flex items-center gap-1"
        >
          <Icon
            name="material-symbols:date-range"
            size="1.2rem"
          />
          {{ props.data.segments.length }} Run{{ props.data.segments.length > 1 ? 's' : '' }}
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.marathon-card:hover {
    border-right-width: 15px;
    border-left-width: 15px;
}
</style>@/utils
@/models/api