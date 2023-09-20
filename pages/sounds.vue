<script setup lang="ts">
import { Sound, SoundsData } from '@/models/api';
import { FilterOption, SortOption } from '@/models/data';

const query = gql`
  query{
    soundsdata {
      updated
      matching
      sounds {
        amount
        description
        verified
        newsound
        matched
      }
    }
  }
`
const isMatching: Ref<Boolean> = ref<Boolean>(false)
const search: Ref<string> = ref<string>('')
type RespondData = {
  soundsdata: SoundsData
}
const { pending, data } = await useLazyAsyncQuery<RespondData>(query)


const sortOptions: SortOption<Sound>[] = [
  {
    name: 'Amount Ascending',
    value: 'amount',
    icon: 'mdi:sort-numeric-ascending',
    sort: (a, b) => (a.amount) - (b.amount)
  },
  {
    name: 'Amount Descending',
    value: 'amount',
    icon: 'mdi:sort-numeric-descending',
    sort: (a, b) => (b.amount) - (a.amount)
  },
  {
    name: 'Description Alphabetical',
    value: 'description',
    icon: 'mdi:alphabetical-variant',
    sort: (a, b) => a.description.localeCompare(b.description)
  }
]
// const all filterOptions flagship, sidequest, pieceofheart
const filterOptions: FilterOption<Sound>[] = [
  {
    name: 'All',
    value: 'all',
    icon: 'ic:baseline-all-inclusive',
    filter: () => true
  },
  {
    name: 'Verified',
    value: 'verified',
    icon: 'bi:patch-check-fill',
    filter: (sound) => sound.verified
  },
  {
    name: 'Unverified',
    value: 'unverified',
    icon: 'bi:patch-question-fill',
    filter: (sound) => !sound.verified
  },
  {
    name: 'New',
    value: 'new',
    icon: 'material-symbols:fiber-new',
    filter: (sound) => sound.newsound
  },
]
const selectedSort: Ref<SortOption<Sound>> = ref(sortOptions[0])
const selectedFilter: Ref<FilterOption<Sound>> = ref(filterOptions[0])
watch(pending, ()=>{
  if(data.value?.soundsdata?.matching) {
    const p = filterOptions.push({
      name: 'Not matched',
      value: 'matched',
      icon: 'bi:patch-exclamation-fill',
      filter: (sound) => !sound.matched
    })
    selectedFilter.value = filterOptions[p-1]
  }
})
useSeoMeta({
  title: 'Sounds - Bokoblin',
})
useServerSeoMeta({
  description: `List of all currently known secret sounds, including amounts and their descriptions`,
  ogTitle: 'Sounds - Bokoblin',
  ogDescription: `List of all currently known secret sounds, including amounts and their descriptions`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <div class="text-sm text-gray-500 text-center">
      Secret Sounds List
    </div>
    <div class="grid grid-cols-1 gap-2 lg:grid-cols-3">
      <div v-if="data?.soundsdata">
        <template v-if="data.soundsdata.matching">
          <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600 mb-3">
            <div class="p-2">
              <span class="relative">
                <Icon
                  name="material-symbols:release-alert-rounded" 
                  size="1.2rem"
                  class="animate-ping absolute top-[2px] text-red-600"
                />
                <Icon
                  name="material-symbols:release-alert-rounded" 
                  size="1.2rem"
                  class="relative text-red-600"
                />
              </span>
              Donation matching mode is active. Check for cells that are NOT red to donate next! Check "Classic View" for the most up-to-date tracking.
            </div>
            <div class="p-2">
              <Icon
                name="material-symbols:crisis-alert" 
                size="1.2rem"
              />
              {{ data.soundsdata.sounds.filter((sound) => { return sound.matched }).length }} / {{ data.soundsdata.sounds.length }} matched
            </div>
          </div>
        </template>
        <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <div class="p-2">
            <Icon
              name="material-symbols:target" 
              size="1.2rem"
            />
            {{ data.soundsdata.sounds.filter((sound) => { return sound.verified }).length }} / {{ data.soundsdata.sounds.length }} heard ({{ (data.soundsdata.sounds.filter((sound) => { return sound.verified }).length / data.soundsdata.sounds.length * 100).toFixed(2) }}%)
          </div>
          <div class="p-2">
            <Icon
              name="material-symbols:fiber-new" 
              size="1.2rem"
            />
            {{ data.soundsdata.sounds.filter((sound) => { return sound.newsound }).length }} new sounds
          </div>
          <div class="p-2">
            <Icon
              name="material-symbols:add-chart-outline-rounded" 
              size="1.2rem"
            />
            {{ toUSD(data.soundsdata.sounds.reduce((a, b) => a + ((b.amount ?? 0) / 100), 0)) }} sum
          </div>
          <div class="p-2">
            <Icon
              name="ic:twotone-graphic-eq" 
              size="1.2rem"
            />
            {{ toUSD(data.soundsdata.sounds.reduce((a, b) => a + ((b.amount ?? 0) / 100), 0) / data.soundsdata.sounds.length) }} avg
          </div>
        </div>
        <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600 my-3">
          <div
            v-if="data.soundsdata.updated"
            class="p-2"
          >
            {{ new Date(data.soundsdata.updated).toLocaleString() }} last updated
          </div>
          <div class="p-2">
            Tracking made possible by our editors @ The Doc Team
          </div>
          <div class="p-2">
            Prefer the Google Sheet document?
            <div class="my-3">
              <nuxt-link to="https://doc.bokoblin.com">
                <span class="rounded bg-green-500 hover:bg-green-400 text-white p-2 whitespace-pre">
                  Open Classic View
                </span>
              </nuxt-link>
            </div>
          </div>
        </div>
        <p class="dark:text-slate-900 text-white text-sm text-center cursor-default">
          It's a secret to everybody.
        </p>
      </div>
      <div v-else>
        <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600 mb-3">
          <div class=" p-2">
            <Icon
              name="svg-spinners:8-dots-rotate"
              size="1.5rem"
            />
            Fetching sound data!
          </div>
        </div>
      </div>
      <div class="md:col-span-2">
        <div>
          <label
            for="search"
            class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-100"
          >Quick search</label>
          <div class="relative mt-2 flex items-center">
            <input
              id="search"
              v-model="search"
              type="text"
              name="search"
              class="dark:bg-black block w-full rounded-md border-0 py-1.5 pr-14 text-gray-900 dark:text-gray-100 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 placeholder:text-gray-400 dark:placeholder:text-gray-700 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
            >
          </div>
        </div>
        <sort-and-filter
          :sort-options="sortOptions"
          :filter-options="filterOptions"
          :selected-sort="selectedSort"
          :selected-filter="selectedFilter"
          @sort="selectedSort = $event"
          @filter="selectedFilter = $event"
        />
        <div class="flow-root overflow-x-hidden overflow-y-auto shadow ring-1 ring-black dark:ring-gray-700 ring-opacity-5 max-h-[65vh] sm:rounded-lg">
          <table class="w-full divide-y divide-gray-300 dark:divide-gray-700">
            <thead class="bg-gray-50 dark:bg-slate-700 sticky top-0">
              <tr>
                <th
                  scope="col"
                  class="relative isolate py-3.5 pl-4 pr-1 text-left text-sm font-semibold text-gray-900 dark:text-gray-100 sm:pl-3"
                >
                  Amount
                </th>
                <th
                  scope="col"
                  class="relative isolate px-2 py-3.5 text-left text-sm font-semibold text-gray-900 dark:text-gray-100"
                >
                  Description
                </th>
                <th
                  scope="col"
                  class="relative isolate px-2 py-3.5 text-left text-sm font-semibold text-gray-900 dark:text-gray-100 sm:pl-3"
                >
                  Status
                </th>
              </tr>
            </thead>
            <tbody v-if="(data?.soundsdata.sounds.length ?? 0) == 0">
              <tr>
                <td class="p-2">
                  <Icon
                    name="svg-spinners:8-dots-rotate"
                    size="1.5rem"
                  />
                  Fetching sounds list...
                </td>
              </tr>
            </tbody>
            <tbody
              v-else-if="data.soundsdata.sounds.filter((s) => s.description.toLocaleLowerCase().indexOf(search.toLocaleLowerCase()) >= 0).filter(selectedFilter.filter).sort(selectedSort.sort).length > 0"
              class="divide-y divide-gray-200 bg-white dark:bg-slate-800 dark:divide-gray-700"
            >
              <tr
                v-for="sound in data.soundsdata.sounds.filter((s) => s.description.toLocaleLowerCase().indexOf(search.toLocaleLowerCase()) >= 0).filter(selectedFilter.filter).sort(selectedSort.sort)"
                :key="sound.amount"
                :class="`${sound.matched && isMatching ? 'bg-red-500' : ''}`"
              >
                <td class="whitespace-nowrap p-2 text-sm font-medium text-gray-900 dark:text-gray-100 sm:pl-3">
                  <nuxt-link :to="`https://donate.zeldathon.com?amount=${sound.amount/100}`">
                    {{ toUSD(sound.amount / 100) }}
                  </nuxt-link>
                </td>
                <td class="p-2 text-sm text-gray-500 dark:text-gray-200">
                  {{ sound.description }}
                </td>
                <td class="text-center">
                  <Icon
                    v-if="sound.matched && isMatching"
                    name="bi:patch-exclamation-fill"
                    size="1.2rem"
                    title="Matched"
                  />
                  <Icon
                    v-if="sound.verified"
                    name="bi:patch-check-fill"
                    size="1.2rem"
                    title="Verified"
                  />
                  <Icon
                    v-else
                    name="bi:patch-question-fill"
                    size="1.2rem"
                    class="text-gray-300 dark:text-gray-700"
                    title="Unverified"
                  />
                  <Icon
                    v-if="sound.newsound"
                    name="material-symbols:fiber-new"
                    size="1.2rem"
                    title="New"
                  />
                </td>
              </tr>
            </tbody>
            <tbody v-else>
              <tr>
                <td class="p-2">
                  No Results
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>