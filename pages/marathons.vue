<script setup lang="ts">
import type { Marathon } from '@/models/api'
import type { SortOption, FilterOption } from '@/models/data'
const query = gql`
  query {
    marathons {
        id
        full_name
        color
        type
        start_date
        stop_date
        total
        charity {
            id
            full_name
            website
        }
        attendance_count
        segments_count
        playlist
    }
  }
  `
const marathons: Ref<Marathon[]> = ref<Marathon[]>([])
type RespondData = {
    marathons: Marathon[]
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.marathons) {
  marathons.value = [...data.value.marathons].sort((a, b) => {
    return (new Date(b.start_date)).getTime() - new Date(a.start_date).getTime()
  })
}

const sortOptions: SortOption<Marathon>[] = [
  {
    name: 'Date Descending (Newest)',
    value: 'recent',
    icon: 'mdi:sort-calendar-descending',
    sort: (a, b) => (new Date(b.start_date).getTime()) - (new Date(a.start_date).getTime())
  },
  {
    name: 'Date Ascending (Oldest)',
    value: 'oldest',
    icon: 'mdi:sort-calendar-ascending',
    sort: (a, b) => (new Date(a.start_date).getTime()) - (new Date(b.start_date).getTime())
  },
  {
    name: 'Name Alphabetical',
    value: 'alphabetical',
    icon: 'mdi:alphabetical-variant',
    sort: (a, b) => a.full_name.localeCompare(b.full_name)
  },
  {
    name: 'Total Raised',
    value: 'total',
    icon: 'mdi:sort-numeric-ascending',
    sort: (a, b) => b.total - a.total
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
  },
  {
    name: 'Attendance',
    value: 'attendance',
    icon: 'ic:baseline-person',
    sort: (a, b) => (b.attendance_count ?? 0) - (a.attendance_count ?? 0)
  },
  {
    name: 'Segments',
    value: 'segments',
    icon: 'ic:baseline-segment',
    sort: (a, b) => (b.segments_count ?? 0) - (a.segments_count ?? 0)
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
useSeoMeta({
  title: 'Marathons - Bokoblin',
})
useServerSeoMeta({
  description: `Archive data for ${marathons.value.length} marathons.`,
  ogTitle: 'Marathons - Bokoblin',
  ogDescription: `Archive data for ${marathons.value.length} marathons.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      Marathons
    </h1>
    <sort-and-filter
      :sort-options="sortOptions"
      :filter-options="filterOptions"
      :selected-sort="selectedSort"
      :selected-filter="selectedFilter"
      @sort="selectedSort = $event"
      @filter="selectedFilter = $event"
    />
    <div
      class="flex flex-col gap-2"
    >
      <marathon-card
        v-for="marathon in marathons.sort(selectedSort.sort).filter(selectedFilter.filter)"
        :key="marathon.id"
        :data="marathon"
      />
    </div>
  </div>
</template>
