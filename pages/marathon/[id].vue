<script setup lang="ts">
import type { Marathon, Segment } from '@/models/api'
import type { SortOption, FilterOption } from '@/models/data'
type Stat = {
    name: string
    value: string
    subvalue?: string
}
const route = useRoute()
const marathonID = route.params.id
const query = gql`
query {
  marathon(id: ${marathonID}) {
    id
    color
    type
    type_id
    total
    full_name
    playlist
    start_date
    stop_date
    charity{
        id
        slug
    }
  }
}
`
const lazyQuery = gql`
query {
  marathon(id: ${marathonID}) {
    donationsTime{
        hour
        total
    }
    attendance{
        attendee{
            id
            name
            rank
        }
        award
        location
    }
    segments{
        id
        game{
            title
            id
            iszelda
            isevent
        }
        modifier
        runners{
            attendee{
                name
                id
                rank
            }
            rank
        }
        filenames{
            filename
            note
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
const marathon: Ref<Marathon | null> = ref<Marathon | null>(null)
const duration = ref<number | null>(null)
const totalPerHour = ref<number | null>(null)
const durationString = ref<string | null>(null)
const stats = ref<Stat[]>([])

type RespondData = {
    marathon: Marathon
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.marathon) {
  marathon.value = {
    ...marathon.value,
    ...data.value.marathon
  }
  duration.value = (new Date(marathon.value!.stop_date).getTime() - new Date(marathon.value!.start_date).getTime())
  durationString.value = toTimestamp(marathon.value!.start_date, marathon.value!.stop_date)
  totalPerHour.value = marathon.value!.total / (duration.value / 3600000)
  stats.value = [
    {
      name: 'Total',
      value: toUSD(marathon.value?.total ?? 0),
      subvalue: '~' + toUSD(totalPerHour.value ?? 0) + '/hr'
    },
    {
      name: 'Duration',
      value: durationString.value ?? 'Unknown',
      subvalue: `${new Date(marathon.value?.start_date ?? '').toLocaleString()}\n${new Date(marathon.value?.stop_date ?? '').toLocaleString()}`
    },
    {
      name: 'Charity',
      value: marathon.value?.charity.slug ?? 'Unknown'
    }
  ]
}
const { pending, data: lazyData } = await useLazyAsyncQuery<RespondData>(lazyQuery)
const sortOptions: SortOption<Segment>[] = [
  {
    name: 'Date Ascending (Start-End)',
    value: 'oldest',
    icon: 'mdi:sort-calendar-ascending',
    sort: (a, b) => (new Date(a.start_time).getTime()) - (new Date(b.end_time).getTime())
  },
  {
    name: 'Date Descending (End-Start)',
    value: 'recent',
    icon: 'mdi:sort-calendar-descending',
    sort: (a, b) => (new Date(b.start_time).getTime()) - (new Date(a.end_time).getTime())
  },
  {
    name: 'Game Alphabetical',
    value: 'alphabetical',
    icon: 'mdi:alphabetical-variant',
    sort: (a, b) => (a.game?.title ?? '').localeCompare(b.game?.title ?? '')
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
    sort: (a, b) => (b.runners?.length ?? 0) - (a.runners?.length ?? 0)
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
    name: 'Special Event',
    value: 'special',
    icon: 'material-symbols:award-star-rounded',
    filter: a => a.game?.isevent ?? false
  },
  {
    name: 'Zelda Game',
    value: 'zelda',
    icon: 'tabler:sword',
    filter: a => a.game?.iszelda ?? false
  },
  {
    name: 'NOT Zelda Game',
    value: 'notzelda',
    icon: 'tabler:sword-off',
    filter: a => !a.game?.iszelda ?? true
  }
]
const selectedSort: Ref<SortOption<Segment>> = ref(sortOptions[0])
const selectedFilter: Ref<FilterOption<Segment>> = ref(filterOptions[0])
useSeoMeta({
  title: `${marathon.value?.full_name} - Bokoblin`,
})
useServerSeoMeta({
  description: `Archive data for ${marathon.value?.full_name} which raised ${toUSD(marathon.value?.total ?? 0)} for ${marathon.value?.charity.slug}`,
  title: `${marathon.value?.full_name} - Bokoblin`,
  ogDescription: `Archive data for ${marathon.value?.full_name} which raised ${toUSD(marathon.value?.total ?? 0)} for ${marathon.value?.charity.slug}`,
  themeColor: `${marathon.value?.color ?? '#FF5959'}`
})
</script>
<template>
  <div
    v-if="marathon"
  >
    <div class="text-sm text-gray-500 text-center">
      Marathon
    </div>
    <div
      class="flex justify-center items-center py-1"
    >
      <div
        class="text-3xl px-3 py-1 text-center font-bold text-white hover:scale-110 transition-all group rounded shadow flex justify-center items-center"
        :style="`background-color: #${marathon.color ?? '000000'};`"
      >
        {{ marathon.full_name }}
        <div class="w-0 overflow-hidden ml-1 group-hover:w-9 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
          {{ marathon.id }}
        </div>
      </div>
    </div>
    <h2 class="text-2xl mb-3 text-center font-bold">
      {{ toReadableDate(marathon.start_date) }} - {{ toReadableDate(marathon.stop_date) }}
    </h2>
    <div>
      <div class="mx-auto max-w-4xl">
        <div class="grid grid-cols-1 gap-px bg-black/10 dark:bg-white/5 sm:grid-cols-1 lg:grid-cols-3">
          <div
            v-for="stat in stats"
            :key="stat.name"
            class="bg-white dark:bg-gray-900 px-4 py-2 sm:px-6 lg:px-s8"
          >
            <p class="text-sm font-medium leading-6 text-gray-700 dark:text-gray-400">
              {{ stat.name }}
            </p>
            <p class="mt-2 flex items-baseline gap-x-2">
              <span class="text-4xl font-semibold tracking-tight dark:text-white">{{ stat.value }}</span>
            </p>
            <p class="mt-2 flex items-baseline gap-x-2">
              <span
                v-if="stat.subvalue"
                class="text-sm text-gray-400"
                style="white-space: pre;"
              >{{ stat.subvalue }}</span>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div v-if="pending">
      <h3 class="text-center text-xl my-3.5">
        <Icon
          name="svg-spinners:8-dots-rotate"
          size="1.5rem"
        />
        Fetching Marathon Details...
      </h3>
    </div>
    <div
      v-else
      class="grid grid-cols-1 md:grid-cols-2 my-4 gap-3"
    >
      <div>
        <template v-if="lazyData.marathon.donationsTime.length > 0">
          <h3 class="text-center text-xl my-3.5">
            Donations Over Time
          </h3>
          <div class="rounded border p-2 dark:bg-slate-800 dark:text-gray-300 dark:border-gray-600">
            <!-- Combine the two marathon objects because the lazy query doesn't return the color -->
            <donations-over-time-graph :data="{...marathon, ...lazyData.marathon}" />
          </div>
        </template>
        <h3 class="text-center text-xl my-3.5">
          Attendance ({{ lazyData.marathon.attendance?.length ?? 0 }})
        </h3>
        <div class="rounded border grid grid-cols-2 divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <nuxt-link
            v-for="attendance in
              lazyData.marathon.attendance?.filter(a => a.attendee.rank !== '2').sort((a, b) => a.attendee.name.localeCompare(b.attendee.name)) ?? []"
            :key="attendance.attendee.id"
            :to="`/attendee/${attendance.attendee.id}`"
            class="p-2"
            :title="attendance.award"
          >
            {{ attendance.attendee.name }}
            <span
              v-if="attendance.location !== 'In-Person'"
              class="text-gray-500 text-sm"
            >({{ attendance.location }})</span>
          </nuxt-link>
        </div>
      </div>
      <div>
        <h3 class="text-center text-xl my-3.5">
          Segments ({{ lazyData.marathon.segments.length }})
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
          v-for="segment in lazyData.marathon.segments.filter(selectedFilter.filter).sort(selectedSort.sort)"
          :key="segment.id"
          :data="segment"
          class="my-2"
        />
      </div>
    </div>
  </div>
</template>
