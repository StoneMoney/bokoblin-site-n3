<script setup lang="ts">
import type { Charity } from '@/models/api'
import type { SortOption } from '@/models/data'
const query = gql`
  query {
    charities {
      full_name
      total
      website
      id
      marathons{
        color
      }
    }
  }
  `
const charities: Ref<Charity[]> = ref<Charity[]>([])
type RespondData = {
  charities: Charity[]
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.charities) {
  charities.value = data.value.charities
}

const sortOptions: SortOption<Charity>[] = [
  {
    name: 'Alphabetical',
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
    name: 'Event Count',
    value: 'events',
    icon: 'material-symbols:date-range',
    sort: (a, b) => (b.marathons.length ?? 0) - (a.marathons.length ?? 0)
  }
]
const selectedSort: Ref<SortOption<Charity>> = ref(sortOptions[0])
useSeoMeta({
  title: 'Causes - Bokoblin',
})
useServerSeoMeta({
  description: `Bokoblin archive data for ${charities.value.length} games.`,
  ogTitle: 'Causes - Bokoblin',
  ogDescription: `Bokoblin archive data for ${charities.value.length} games.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      Causes ({{ charities.length }})
    </h1>
    <sort-and-filter
      :sort-options="sortOptions"
      :selected-sort="selectedSort"
      @sort="selectedSort = $event"
    />
    <div
      class="flex flex-col gap-2"
    >
      <cause-card
        v-for="charity in charities.sort(selectedSort.sort)"
        :key="charity.id"
        :data="charity"
      />
    </div>
  </div>
</template>
