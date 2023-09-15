<script setup lang="ts">
import type { Game, Segment } from '@/models/api'
import type { FilterOption, SortOption } from '@/models/data'

const route = useRoute()
const gameID = route.params.id
const query = gql`
query {
  game(id:${gameID}) {
    id
    title
    iszelda
    isevent
    segments {
      id
      modifier
      raised
      game {
        id
        title
      }
      marathon {
        full_name
        color
        id
        type
      }
      runners{
        attendee{
          name
          id
          rank
        }
        rank
      }
      raised
      start_time
      end_time
      vod
      time_offset
    }
  }
}
`

const game = ref<Game | undefined>()
const screentime = ref<number>(0)
const raised = ref<number>(0)
type RespondData = {
  game: Game
}

const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.game) {
  game.value = data.value.game
  screentime.value = data.value.game.segments.reduce((a, b) => a + (getDurationNumberal(b.end_time, b.start_time)), 0)
  raised.value = data.value.game.segments.reduce((a, b) => a + (b.raised ?? 0), 0)
}
const sortOptions: SortOption<Segment>[] = [
  {
    name: 'Date Ascending',
    value: 'oldest',
    icon: 'mdi:sort-calendar-ascending',
    sort: (a, b) => (new Date(a.start_time).getTime()) - (new Date(b.end_time).getTime())
  },
  {
    name: 'Date Descending',
    value: 'recent',
    icon: 'mdi:sort-calendar-descending',
    sort: (a, b) => (new Date(b.start_time).getTime()) - (new Date(a.end_time).getTime())
  },
  {
    name: 'Longest',
    value: 'durationl',
    icon: 'bx:stopwatch',
    sort: (a, b) => (getDurationNumberal(a.end_time, a.start_time)) - (getDurationNumberal(b.end_time, b.start_time))
  },
  {
    name: 'Shortest',
    value: 'durations',
    icon: 'bx:stopwatch',
    sort: (a, b) => (getDurationNumberal(b.end_time, b.start_time)) - (getDurationNumberal(a.end_time, a.start_time))
  },
  {
    name: 'Total Raised',
    value: 'total',
    icon: 'mdi:sort-numeric-ascending',
    sort: (a, b) => (b.raised ?? 0) - (a.raised ?? 0)
  },
  {
    name: 'Runner Count',
    value: 'runners',
    icon: 'ic:baseline-person',
    sort: (a, b) => (b.runners.length ?? 0) - (a.runners.length ?? 0)
  }
]
// const all filterOptions flagship, sidequest, pieceofheart
const filterOptions: FilterOption<Segment>[] = [
  {
    name: 'All',
    value: 'all',
    icon: 'ic:baseline-all-inclusive',
    filter: () => true
  },
  {
    name: 'Has VOD',
    value: 'vod',
    icon: 'ic:baseline-video-library',
    filter: a => a.vod.length > 0
  },
  {
    name: 'At Zeldathon',
    value: 'zelda',
    icon: 'tabler:sword',
    filter: a => (a.marathon?.type === "1" || a.marathon?.type === "2") ?? false
  },
  {
    name: 'NOT At Zeldathon',
    value: 'notzelda',
    icon: 'tabler:sword-off',
    filter: a => (a.marathon?.type !== "1" && a.marathon?.type !== "2") ?? false
  }
]
const selectedSort: Ref<SortOption<Segment>> = ref(sortOptions[0])
const selectedFilter: Ref<FilterOption<Segment>> = ref(filterOptions[0])
if(game.value) {
  useSeoMeta({
    title: `${game.value.title} - Bokoblin`,
  })
  useServerSeoMeta({
    description: `Bokoblin archive data for ${game.value.title} ${game.value.segments.length > 0 ? ', which has been run ' + game.value.segments.length + ' times' : ''}.`,
    ogTitle: `${game.value.title} - Bokoblin`,
    ogDescription: `Bokoblin archive data for ${game.value.title} ${game.value.segments.length > 0 ? ', which has been run ' + game.value.segments.length + ' times' : ''}.`,
    themeColor: `#FF5959`
  })
}
</script>
<template>
  <div
    v-if="game"
    class="flex justify-center"
  >
    <div class="max-w-5xl">
      <div class="text-sm text-gray-500 text-center">
        Game
        <Icon
          v-if="game.iszelda"
          name="tabler:sword"
          size="1.2rem"
          title="Zelda Game!"
        />
        <Icon
          v-if="game.isevent"
          name="material-symbols:award-star-rounded"
          size="1.2rem"
          title="Special Event!"
        />
      </div>
      <div
        class="flex justify-center items-center py-1"
      >
        <div
          class="text-3xl px-3 py-1 text-center font-bold bg-slate-500 text-white hover:scale-110 transition-all group rounded shadow flex justify-center items-center"
        >
          {{ game.title }}
          <div class="w-0 overflow-hidden ml-1 group-hover:w-9 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
            {{ game.id }}
          </div>
        </div>
      </div>
      <div class="grid grid-cols-1 gap-2 sm:grid-cols-3">
        <div>
          <h3 class="text-center text-xl my-3.5">
            Stats
          </h3>
          <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
            <div class="p-2">
              <Icon
                name="clarity:dollar-bill-solid"
                size="1.2rem"
              />
              {{ toUSD(raised ?? 0) }} raised ({{ toUSD((raised ?? 0) / -screentime) }}/hr)
            </div>
            <div class="p-2">
              <Icon
                name="bx:stopwatch"
                size="1.2rem"
              />
              {{ toTimestamp(new Date(screentime * 3.6e+6), new Date(0)) }} total screentime
            </div>
          </div>
        </div>
        <div class="sm:col-span-2">
          <h3 class="text-center text-xl my-3.5">
            Segments ({{ game.segments.length ?? 0 }})
          </h3>
          <sort-and-filter
            :sort-options="sortOptions"
            :filter-options="filterOptions"
            :selected-sort="selectedSort"
            :selected-filter="selectedFilter"
            @sort="selectedSort = $event"
            @filter="selectedFilter = $event"
          />
          <segment-card
            v-for="segment in game.segments.filter(selectedFilter.filter).sort(selectedSort.sort)"
            :key="segment.id"
            :data="segment"
            class="my-2"
          />
        </div>
      </div>
    </div>
  </div>
</template>