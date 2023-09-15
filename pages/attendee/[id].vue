<script setup lang="ts">
import { Attendee, Segment } from '@/models/api'
import { FilterOption, SortOption } from '@/models/data'

const route = useRoute()
const attendeeID = route.params.id
const query = gql`
query {
  attendee(id: ${attendeeID}) {
    attendance {
      award
      location
      marathon {
        color
        id
        full_name
        type
      }
    }
    house
    house_color
    id
    name
    rank
    segments {
      id
      marathon {
        color
        full_name
        id
      }
      game {
        id
        isevent
        iszelda
        title
      }
      modifier
      raised
      start_time
      end_time
      vod
      time_offset
      runners {
        attendee {
          name
          rank
          id
        }
        rank
      }
    }
  }
}
`

const attendee = ref<Attendee | undefined>()
const runnerEvents = ref<Set<string> | undefined>(undefined)
type RespondData = {
  attendee: Attendee
}

const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.attendee) {
  attendee.value = data.value.attendee
  const mIDs = attendee.value.segments.map(s => s.marathon?.id ?? "")
  runnerEvents.value = new Set(mIDs)
}

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
    sort: (a, b) => (b.runners.length ?? 0) - (a.runners.length ?? 0)
  }
]
const filterOptions: FilterOption<Segment>[] = [
  {
    name: 'All',
    value: 'all',
    icon: 'ic:baseline-all-inclusive',
    filter: () => true
  },
  {
    name: 'Hosting',
    value: 'host',
    icon: 'tabler:broadcast',
    filter: a => a.runners.some(r => r.rank === 0 && r.attendee.id === attendeeID)
  },
  {
    name: 'Commentating',
    value: 'commentary',
    icon: 'material-symbols:mic',
    filter: a => a.runners.some(r => r.rank === 1 && r.attendee.id === attendeeID)
  },
  {
    name: 'Participating',
    value: 'participant',
    icon: 'mdi:controller-classic',
    filter: a => a.runners.some(r => r.rank === 2 && r.attendee.id === attendeeID)
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
if(attendee.value) {
  useSeoMeta({
    title: `${attendee.value.name} - Bokoblin`,
  })
  useServerSeoMeta({
    description: `Bokoblin archive data for ${attendee.value.name}${attendee.value.segments.length > 0 ? `, including ${attendee.value.segments.length} segments` : ''}.`,
    ogTitle: `${attendee.value.name} - Bokoblin`,
    ogDescription: `Bokoblin archive data for ${attendee.value.name}${attendee.value.segments.length > 0 ? `, including ${attendee.value.segments.length} segments` : ''}.`,
    themeColor: `#FF5959`
  })
}
</script>
<template>
  <div v-if="attendee">
    <div class="text-sm text-gray-500 text-center">
      Attendee
    </div>
    <div
      class="flex justify-center items-center py-1"
    >
      <div
        class="text-3xl px-3 py-1 text-center font-bold text-white hover:scale-110 transition-all group rounded shadow flex justify-center items-center"
        :style="`background-color: #${attendee.house_color ?? '6b7280'};`"
      >
        {{ attendee.name }}
        <div class="w-0 overflow-hidden ml-1 group-hover:w-9 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
          {{ attendee.id }}
        </div>
      </div>
    </div>
    <div class="grid grid-cols-1 gap-2 sm:grid-cols-2">
      <div>
        <h3 class="text-center text-xl my-3.5">
          Attendance ({{ attendee.attendance?.length ?? 0 }})
        </h3>
        <div class="flex flex-col items-center">
          <template v-if="(attendee.attendance?.filter((m) => m.marathon.type === '1' || m.marathon.type === '2').length ?? 0) > 0">
            <img
              src="/Trophy_Top.svg"
              alt="Top of the Attendee Trophy, a triforce"
              class="w-48"
            >
            <div
              v-for="attending in attendee.attendance?.filter((m) => m.marathon.type === '1' || m.marathon.type === '2').reverse()"
              :key="attending.marathon.id"
              :style="`background-color: #${attending.marathon.color ?? '000000'};`"
              :class="`p-2 flex items-center justify-center w-36 ${runnerEvents?.has(attending.marathon.id) ? 'border-r-4 border-l-4 border-yellow-400/75' : ''}`"
            >
              <nuxt-link :to="`/marathon/${attending.marathon.id}`">
                <img
                  :src="`/marathon/${attending.marathon.id}.svg`"
                  class="h-6"
                  :title="`${attending.award ? `'${attending.award}' award - ` : ''}${attending.location}${runnerEvents?.has(attending.marathon.id) ? ' - Runner' : ''}`"
                >
              </nuxt-link>
            </div>
            <img
              src="/Trophy_Bottom.svg"
              alt="Bottom of the Attendee Trophy, a black rectangle with the Zeldathon logo"
              class="w-48"
            >
          </template>
          <div class="flex flex-wrap gap-4 my-2">
            <div
              v-for="attending in attendee.attendance?.filter((m) => m.marathon.type !== '1' && m.marathon.type !== '2')"
              :key="attending.marathon.id"
              :style="`background-color: #${attending.marathon.color ?? '000000'};`"
              :class="`p-2 rounded-full flex items-center justify-center w-12 ${runnerEvents?.has(attending.marathon.id) ? 'border-r-4 border-l-4 border-yellow-400/75' : ''}`"
            >
              <nuxt-link :to="`/marathon/${attending.marathon.id}`">
                <img
                  :src="`/icons/${attending.marathon.type}.svg`"
                  class="h-6 invert"
                  :title="`${attending.marathon.full_name}${runnerEvents?.has(attending.marathon.id) ? ' - Runner' : ''}`"
                >
              </nuxt-link>
            </div>
          </div>
        </div>
      </div>
      <div>
        <h3 class="text-center text-xl my-3.5">
          Segements ({{ attendee.segments.length }})
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
          v-for="segment in attendee.segments.filter(selectedFilter.filter).sort(selectedSort.sort)"
          :key="segment.id"
          :data="segment"
          class="my-2"
        />
      </div>
    </div>
  </div>
</template>