<script setup lang="ts">
import type { Charity } from '@/models/api'
const props = defineProps<{
    data: Charity;
}>()
const total = toUSD(props.data.total)
</script>
<template>
  <div class="border dark:border-gray-600 rounded-md group">
    <div
      class="bg-slate-50 group-hover:bg-slate-100 dark:bg-slate-800 group-hover:dark:bg-slate-700 shadow-sm rounded-md py-1 px-2 border-r-4 group-hover:border-r-8 transition-all grid grid-cols-2 sm:grid-cols-3  min-h-[80px]"
      :style="`border-right-color: ${props.data.marathons[0] ? '#'+props.data.marathons[0]?.color : 'unset'};`"
    >
      <div class="flex flex-col gap-2 col-span-2">
        <nuxt-link :to="`/cause/${props.data.id}`">
          <div class="text-2xl font-semibold">
            {{ props.data.full_name }}
          </div>
        </nuxt-link>
        <div
          v-if="props.data.website"
          class="pb-2"
        >
          <nuxt-link
            ref="noopener"
            :to="props.data.website"
            target="_blank"
          >
            Visit Website
          </nuxt-link>
        </div>
      </div>
      <div class="grid grid-cols-2 sm:flex sm:flex-col text-gray-400 items-end justify-around col-span-2 sm:col-span-1">
        <div
          v-if="total"
          class="flex items-center gap-1"
        >
          <Icon
            name="clarity:dollar-bill-solid"
            size="1.2rem"
          />
          {{ total }}
        </div>
        <div
          v-if="props.data.marathons.length > 0"
          class="flex items-center gap-1"
        >
          <Icon
            name="material-symbols:date-range"
            size="1.2rem"
          />
          {{ props.data.marathons.length }} Event{{ props.data.marathons.length > 1 ? 's' : '' }}
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