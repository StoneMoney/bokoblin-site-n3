<script setup lang="ts">
import { SortOption, FilterOption } from '@/models/data'
const props = defineProps({
  selectedSort: {
    type: Object as PropType<SortOption<any>>,
      default: null
  },
  selectedFilter: {
    type: Object as PropType<FilterOption<any>>,
      default: null
  },
  sortOptions: {
    type: Array as PropType<SortOption<any>[]>,
      default: null
  },
  filterOptions: {
    type: Array as PropType<FilterOption<any>[]>,
    default: null
  }
})
const emit = defineEmits(['sort', 'filter'])

const selectedSortMutation = ref<SortOption<any>>(props.selectedSort ?? null)
const selectedFilterMutation = ref<FilterOption<any>>(props.selectedFilter ?? null)

watch(selectedSortMutation, (newVal) => {
  emit('sort', newVal)
})
watch(selectedFilterMutation, (newVal) => {
  emit('filter', newVal)
})
</script>
<template>
  <div class="grid grid-cols-2 gap-3 my-3">
    <HeadlessListbox
      v-if="sortOptions"
      v-model="selectedSortMutation"
      as="div"
    >
      <HeadlessListboxLabel class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-200">
        Sort by
      </HeadlessListboxLabel>
      <div class="relative mt-1">
        <HeadlessListboxButton class="relative w-full cursor-default rounded-md bg-white dark:bg-black py-1.5 pl-3 pr-10 text-left text-gray-900 dark:text-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6">
          <div class="block truncate">
            <img
              v-if="selectedSort.icon.indexOf('/icons') == 0"
              :src="selectedSort.icon"
              :alt="selectedSort.name"
              class="h-4 w-4 dark:invert"
            >
            <Icon
              v-else
              :name="selectedSort.icon"
            /> {{ selectedSort.name }}
          </div>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-2">
            <Icon name="mdi:chevron-down" />
          </div>
        </HeadlessListboxButton>

        <transition
          leave-active-class="transition ease-in duration-100"
          leave-from-class="opacity-100"
          leave-to-class="opacity-0"
        >
          <HeadlessListboxOptions class="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white dark:bg-black py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm">
            <HeadlessListboxOption
              v-for="sortOption in sortOptions"
              :key="sortOption.value"
              v-slot="{ active, selected }"
              as="template"
              :value="sortOption"
            >
              <li :class="[active ? 'bg-indigo-600 text-white' : 'text-gray-900 dark:text-gray-300', 'relative cursor-default select-none py-2 pl-3 pr-9']">
                <div :class="[selected ? 'font-semibold' : 'font-normal', 'block truncate']">
                  <img
                    v-if="sortOption.icon.indexOf('/icons') == 0"
                    :src="sortOption.icon"
                    :alt="sortOption.name"
                    class="h-4 w-4 dark:invert"
                  >
                  <Icon
                    v-else
                    :name="sortOption.icon"
                  /> {{ sortOption.name }}
                </div>

                <div
                  v-if="selected"
                  :class="[active ? 'text-white' : 'text-indigo-600', 'absolute inset-y-0 right-0 flex items-center pr-4']"
                >
                  <Icon name="ic:baseline-check" />
                </div>
              </li>
            </HeadlessListboxOption>
          </HeadlessListboxOptions>
        </transition>
      </div>
    </HeadlessListbox>
    <!-- Same listbox but for filter -->
    <HeadlessListbox
      v-if="filterOptions"
      v-model="selectedFilterMutation"
      as="div"
      @change="$emit('filter', selectedSortMutation)"
    >
      <HeadlessListboxLabel class="block text-sm font-medium leading-6 text-gray-900 dark:text-gray-200">
        Filter by
      </HeadlessListboxLabel>
      <div class="relative mt-1">
        <HeadlessListboxButton class="relative w-full cursor-default rounded-md bg-white dark:bg-black py-1.5 pl-3 pr-10 text-left text-gray-900 dark:text-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6">
          <div
            class="truncate flex items-center gap-1"
          >
            <img
              v-if="selectedFilter.icon.indexOf('/icons') == 0"
              :src="selectedFilter.icon"
              :alt="selectedFilter.name"
              class="h-4 w-4 dark:invert"
            >
            <Icon
              v-else
              :name="selectedFilter.icon"
            />
            {{ selectedFilter.name }}
          </div>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-2">
            <Icon name="mdi:chevron-down" />
          </div>
        </HeadlessListboxButton>

        <transition
          leave-active-class="transition ease-in duration-100"
          leave-from-class="opacity-100"
          leave-to-class="opacity-0"
        >
          <HeadlessListboxOptions class="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white dark:bg-black py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm">
            <HeadlessListboxOption
              v-for="filterOption in filterOptions"
              :key="filterOption.value"
              v-slot="{ active, selected }"
              as="template"
              :value="filterOption"
            >
              <li :class="[active ? 'bg-indigo-600 text-white' : 'text-gray-900 dark:text-gray-300', 'relative cursor-default select-none py-2 pl-3 pr-9 group']">
                <div :class="[selected ? 'font-semibold' : 'font-normal', 'truncate'] + ' flex items-center gap-1'">
                  <img
                    v-if="filterOption.icon.indexOf('/icons') == 0"
                    :src="filterOption.icon"
                    :alt="filterOption.name"
                    class="h-4 w-4 dark:invert"
                  >
                  <Icon
                    v-else
                    :name="filterOption.icon"
                  />
                  {{ filterOption.name }}
                  <div
                    v-if="selected"
                    :class="[active ? 'text-white' : 'text-indigo-600', 'absolute inset-y-0 right-0 flex items-center pr-4']"
                  >
                    <Icon name="ic:baseline-check" />
                  </div>
                </div>
              </li>
            </HeadlessListboxOption>
          </HeadlessListboxOptions>
        </transition>
      </div>
    </HeadlessListbox>
  </div>
</template>
