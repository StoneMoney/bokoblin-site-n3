<script setup lang="ts">
import type { Charity, Marathon } from '@/models/api'
import type { FilterOption, SortOption } from '@/models/data'

const route = useRoute()
const causeID = route.params.id
const query = gql`
query {
  charity(id:${causeID}) {
    id
    full_name
    website
    total
    marathons {
      id
      full_name
      color
      type
      start_date
      stop_date
      total
      attendance_count
      segments_count
      playlist
    }
  }
}
`

const cause = ref<Charity | undefined>()
type RespondData = {
  charity: Charity
}

const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.charity) {
  cause.value = data.value.charity
}
const sortOptions: SortOption<Marathon>[] = [
  {
    name: 'Date Ascending',
    value: 'oldest',
    icon: 'mdi:sort-calendar-ascending',
    sort: (a, b) => (new Date(a.start_date).getTime()) - (new Date(b.stop_date).getTime())
  },
  {
    name: 'Total Raised',
    value: 'total',
    icon: 'mdi:sort-numeric-ascending',
    sort: (a, b) => (b.total ?? 0) - (a.total ?? 0)
  },
  {
    name: 'Date Descending',
    value: 'recent',
    icon: 'mdi:sort-calendar-descending',
    sort: (a, b) => (new Date(b.start_date).getTime()) - (new Date(a.stop_date).getTime())
  },
  {
    name: 'Longest',
    value: 'durationl',
    icon: 'bx:stopwatch',
    sort: (a, b) => (getDurationNumberal(a.stop_date, a.start_date)) - (getDurationNumberal(b.stop_date, b.start_date))
  },
  {
    name: 'Shortest',
    value: 'durations',
    icon: 'bx:stopwatch',
    sort: (a, b) => (getDurationNumberal(b.stop_date, b.start_date)) - (getDurationNumberal(a.stop_date, a.start_date))
  }
]
// const all filterOptions flagship, sidequest, pieceofheart
const filterOptions: FilterOption<Marathon>[] = [
  {
    name: 'All',
    value: 'all',
    icon: 'ic:baseline-all-inclusive',
    filter: () => true
  },
  {
    name: 'Flagship',
    value: 'flagship',
    icon: '/icons/1.svg',
    filter: a => a.type === '1' || a.type === '2'
  },
  {
    name: 'Side Quest',
    value: 'sidequest',
    icon: '/icons/4.svg',
    filter: a => a.type === '4'
  },
  {
    name: 'Piece of Heart',
    value: 'pieceofheart',
    icon: '/icons/5.svg',
    filter: a => a.type === '5'
  }
]
const selectedSort: Ref<SortOption<Marathon>> = ref(sortOptions[0])
const selectedFilter: Ref<FilterOption<Marathon>> = ref(filterOptions[0])
if(cause.value) {
  useSeoMeta({
    title: `${cause.value.full_name} - Bokoblin`,
  })
  useServerSeoMeta({
    description: `Bokoblin archive data for ${cause.value.full_name}${cause.value.marathons.length > 0 ? `, including ${cause.value.marathons.length} marathons` : ''}${cause.value.total > 0 ? ` raising ${toUSD(cause.value.total)} across them` : ''}.`,
    ogTitle: `${cause.value.full_name} - Bokoblin`,
    ogDescription: `Bokoblin archive data for ${cause.value.full_name}${cause.value.marathons.length > 0 ? `, including ${cause.value.marathons.length} marathons` : ''}${cause.value.total > 0 ? ` raising ${toUSD(cause.value.total)} across them` : ''}.`,
    themeColor: `#FF5959`
  })
}
</script>
<template>
  <div
    v-if="cause"
  >
    <div class="max-w-5xl">
      <div class="text-sm text-gray-500 text-center">
        Cause
      </div>
      <div
        class="flex justify-center items-center py-1"
      >
        <div
          class="text-3xl px-3 py-1 text-center font-bold text-white hover:scale-110 transition-all group rounded shadow flex justify-center items-center"
          :style="`background-color: #${cause.marathons[0].color ?? '000000'};`"
        >
          {{ cause.full_name }}
          <div class="w-0 overflow-hidden ml-1 group-hover:w-9 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
            {{ cause.id }}
          </div>
        </div>
      </div>
      <div class="grid grid-cols-1 gap-2 sm:grid-cols-3">
        <div>
          <h3 class="text-center text-xl my-3.5">
            Info
          </h3>
          <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
            <div class="p-2">
              <Icon
                name="clarity:dollar-bill-solid"
                size="1.2rem"
              />
              {{ toUSD(cause.total ?? 0) }} raised
            </div>
            <div
              v-if="cause.website"
              class="p-2"
            >
              <nuxt-link
                :href="cause.website"
              >
                <Icon
                  name="mdi:web"
                  size="1.2rem"
                />
                Website
              </nuxt-link>
            </div>
          </div>
        </div>
        <div class="sm:col-span-2">
          <h3 class="text-center text-xl my-3.5">
            Events ({{ cause.marathons.length ?? 0 }})
          </h3>
          <sort-and-filter
            :sort-options="sortOptions"
            :filter-options="filterOptions"
            :selected-sort="selectedSort"
            :selected-filter="selectedFilter"
            @sort="selectedSort = $event"
            @filter="selectedFilter = $event"
          />
          <marathon-card
            v-for="segment in cause.marathons.filter(selectedFilter.filter).sort(selectedSort.sort)"
            :key="segment.id"
            :data="segment"
            class="my-2"
          />
        </div>
      </div>
    </div>
  </div>
</template>