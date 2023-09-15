<script setup lang="ts">
const expandMore: Ref<boolean> = ref<boolean>(false)
const expandMobile: Ref<boolean> = ref<boolean>(false)
const router = useRouter()
watch(router.currentRoute, () => {
  expandMore.value = false
  expandMobile.value = false
})
</script>
<template>
  <nav class="dark:bg-gray-900 dark:text-white flex flex-col items-center border-b border-gray-400 dark:border-gray-700">
    <div class="flex p-3 max-w-5xl gap-1 md:gap-2">
      <NuxtLink to="/">
        <div class="hover:scale-110 transition py-1 px-3 rounded flex gap-2 font-extrabold">
          <img
            src="~/assets/img/bokoskull.svg"
            alt="Bokoblin"
            class="h-6"
          >
          Bokoblin
        </div>
      </NuxtLink>
      <NuxtLink
        to="/marathons"
        class="sm:block hidden"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/marathons' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Marathons
        </div>
      </NuxtLink>
      <NuxtLink
        to="/sounds"
        class="sm:block hidden"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/sounds' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Sounds
        </div>
      </NuxtLink>
      <NuxtLink
        to="/games"
        class="sm:block hidden"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/games' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Games
        </div>
      </NuxtLink>
      <NuxtLink
        to="/attendees"
        class="sm:block hidden"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/attendees' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          People
        </div>
      </NuxtLink>
      <NuxtLink
        to="/causes"
        class="sm:block hidden"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/causes' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Causes
        </div>
      </NuxtLink>
      <div
        class="cursor-pointer sm:block hidden"
        @click="expandMore = !expandMore"
      >
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded min-w-[85px]">
          {{ expandMore ? 'Less' : 'More' }}
          <Icon :name="expandMore ? `basil:caret-up-outline` : `basil:caret-down-outline`" />
        </div>
      </div>
      <div
        class="cursor-pointer block sm:hidden"
        @click="expandMobile = !expandMobile"
      >
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded  flex justify-center items-center">
          <Icon
            :name="expandMobile ? `ci:close-big` : `ci:hamburger`"
            size="1.5rem"
          />
        </div>
      </div>
      <!-- <div class="hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-3 rounded">
        <Icon name="ci:search-magnifying-glass" />
      </div> -->
    </div>
    <div
      class="overflow-hidden transition-all flex flex-wrap gap-3 sm:hidden"
      :style="expandMore || expandMobile ? `height: 40px;` : 'height: 0px;'"
    >
      <NuxtLink
        to="/marathons"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/marathons' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Marathons
        </div>
      </NuxtLink>
      <NuxtLink
        to="/sounds"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/sounds' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Sounds
        </div>
      </NuxtLink>
      <NuxtLink
        to="/games"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/games' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Games
        </div>
      </NuxtLink>
      <NuxtLink
        to="/attendees"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/attendees' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          People
        </div>
      </NuxtLink>
      <NuxtLink
        to="/causes"
      >
        <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/causes' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
          Causes
        </div>
      </NuxtLink>
    </div>
    <div
      class="overflow-hidden transition-all"
      :style="expandMore || expandMobile ? `height: 40px;` : 'height: 0px;'"
    >
      <div
        class="flex max-w-5xl gap-2 px-2 pb-2"
      >
        <h3 class="py-1 px-3 font-bold">
          Tools:
        </h3>
        <nuxt-link to="/tools/graphs">
          <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/tools/graphs' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
            Graphs
          </div>
        </nuxt-link>
        <nuxt-link to="/tools/time-converter">
          <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/tools/time-converter' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
            Time
          </div>
        </nuxt-link>
        <nuxt-link to="/tools/calc">
          <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/tools/calc' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
            Calculator
          </div>
        </nuxt-link>
        <nuxt-link to="/tools/extension">
          <div :class="`hover:bg-slate-100 dark:hover:bg-gray-800 py-1 px-2 md:px-3 rounded ${router.currentRoute.value.path == '/tools/extension' ? 'bg-slate-100 dark:bg-gray-800' : ''}`">
            Extension
          </div>
        </nuxt-link>
      </div>
    </div>
  </nav>
</template>