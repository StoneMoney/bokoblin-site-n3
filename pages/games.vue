<script setup lang="ts">
import type { Game as GameBase } from '@/models/api'
import type { SortOption, FilterOption } from '@/models/data'
interface Game extends GameBase {
  total: number | undefined;
  totalTime: number | undefined;
}
const query = gql`
  query {
    games {
      id
      title
      iszelda
      isevent
    }
  }
  `
const lazyQuery = gql`
  query {
    games {
      id
      title
      iszelda
      isevent
      segments{
        id
        raised
        start_time
        end_time
      }
    }
  }
`
type RespondData = {
  games: Game[]
}
const { data } = await useAsyncQuery<RespondData>(query)
const { pending, data: lazyData } = await useLazyAsyncQuery<RespondData>(lazyQuery)

const sortOptions: SortOption<Game>[] = [
  {
    name: 'Alphabetical',
    value: 'alphabetical',
    icon: 'mdi:alphabetical-variant',
    sort: (a, b) => a.title.localeCompare(b.title)
  },
  {
    name: 'ID',
    value: 'id',
    icon: 'material-symbols:database',
    sort: (a, b) => parseInt(a.id) - parseInt(b.id)
  },
  {
    name: 'Screentime',
    value: 'screentime',
    icon: 'mdi:clock-time-four-outline',
    sort: (a, b) => (a.totalTime ?? 0) - (b.totalTime ?? 0)
  },
  {
    name: 'Total Raised',
    value: 'total',
    icon: 'mdi:sort-numeric-ascending',
    sort: (a, b) => (b.total ?? 0) - (a.total ?? 0)
  },
  {
    name: 'Segment Count',
    value: 'segments',
    icon: 'material-symbols:date-range',
    sort: (a, b) => (b.segments.length ?? 0) - (a.segments.length ?? 0)
  }
]
const filterOptions: FilterOption<Game>[] = [
  {
    name: 'All',
    value: 'all',
    icon: 'ic:baseline-all-inclusive',
    filter: () => true
  },
  {
    name: 'Special Event',
    value: 'special',
    icon: 'material-symbols:award-star-rounded',
    filter: a => a.isevent ?? false
  },
  {
    name: 'Zelda Game',
    value: 'zelda',
    icon: 'tabler:sword',
    filter: a => a.iszelda ?? false
  },
  {
    name: 'NOT Zelda Game',
    value: 'notzelda',
    icon: 'tabler:sword-off',
    filter: a => !a.iszelda ?? true
  }
]
const selectedSort: Ref<SortOption<Game>> = ref(sortOptions[0])
const selectedFilter: Ref<FilterOption<Game>> = ref(filterOptions[0])
useSeoMeta({
  title: 'Games - Bokoblin',
})
useServerSeoMeta({
  description: `Archive data for ${data.value.games.length} games.`,
  ogTitle: 'Games - Bokoblin',
  ogDescription: `Archive data for ${data.value.games.length} games.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div class="flex justify-center">
    <div class="max-w-2xl">
      <h1 class="text-3xl my-3 text-center font-bold">
        Games ({{ data?.games?.length ?? 0 }})
      </h1>
      <p
        v-if="pending"
        class="text-center"
      >
        Loading full game details...
      </p>
      <sort-and-filter
        :filter-options="filterOptions"
        :selected-filter="selectedFilter"
        :sort-options="sortOptions"
        :selected-sort="selectedSort"
        @sort="selectedSort = $event"
        @filter="selectedFilter = $event"
      />
      <div
        v-if="pending"
        class="flex flex-col gap-2"
      >
        <game-card
          v-for="game in data?.games?.filter(selectedFilter.filter).sort(selectedSort.sort) ?? []"
          :key="game.id"
          :data="game"
        />
      </div>
      <div
        v-else
        class="flex flex-col gap-2"
      >
        <game-card
          v-for="game in lazyData?.games?.filter(selectedFilter.filter).sort(selectedSort.sort) ?? []"
          :key="game.id"
          :data="game"
        />
      </div>
    </div>
  </div>
</template>
