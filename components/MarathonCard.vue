<script setup lang="ts">
import type { Marathon } from '@/models/api'
const props = defineProps<{
    data: Marathon;
}>()
const total = toUSD(props.data.total)
const startDate = toReadableDate(props.data.start_date)
const stopDate = toReadableDate(props.data.stop_date)
</script>
<template>
  <div class="border dark:border-gray-600 rounded-md group">
    <div
      class="bg-slate-50 group-hover:bg-slate-100 dark:bg-slate-800 group-hover:dark:bg-slate-700 shadow-sm rounded-md py-1 px-2 border-r-4 group-hover:border-r-8 transition-all grid grid-cols-2 sm:grid-cols-3"
      :style="`border-right-color: #${props.data.color};`"
    >
      <div class="flex flex-col gap-2 col-span-2">
        <div class="text-sm">
          {{ startDate }} - {{ stopDate }}
        </div>
        <nuxt-link :to="`/marathon/${props.data.id}`">
          <div class="text-2xl font-semibold">
            {{ props.data.full_name }}
          </div>
        </nuxt-link>
        <div
          v-if="props.data.charity"
          class="pb-2"
        >
          {{ total }} for
          <a
            ref="noopener"
            :href="props.data.charity.website"
            target="_blank"
          >{{ props.data.charity.full_name }}</a>
        </div>
        <div v-else>
          {{ total }} raised
        </div>
      </div>
      <div class="flex sm:flex-col text-gray-400 items-end justify-around col-span-2 sm:col-span-1">
        <div
          v-if="(props.data.segments_count ?? 0) > 0"
          class="flex items-center gap-1"
        >
          <Icon
            name="ic:baseline-segment"
            size="1.2rem"
          />
          {{ props.data.segments_count }} Segments
        </div>
        <div
          v-if="(props.data.attendance_count ?? 0) > 0"
          class="flex items-center gap-1"
        >
          <Icon
            name="ic:baseline-person"
            size="1.2rem"
          />
          {{ props.data.attendance_count }} Attendees
        </div>
        <a
          v-if="props.data.playlist"
          ref="noopener"
          :href="`https://www.youtube.com/playlist?list=${ props.data.playlist }`"
          target="_blank"
          class="flex items-center gap-1"
        >
          <Icon
            name="mdi:youtube"
            size="1.2rem"
          />
          Playlist
        </a>
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