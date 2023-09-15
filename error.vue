<script setup lang="ts">
defineProps({
  error: {
    type: Object,
    required: true,
  }
})
</script>
<template>
  <div>
    <NuxtLoadingIndicator color="#ff5959" />
    <AppHeader class="sticky top-0 bg-white dark:bg-slate-900 z-[9999]" />
    <div class="flex items-center flex-col w-full">
      <main class="my-2 px-2 max-w-2xl">
        <h1 class="text-3xl font-bold my-2">
          Whoops!
        </h1>
        <h2
          v-if="error"
          class="text-xl font-semibold my-2"
        >
          {{ error.code }} {{ error.message }}
        </h2>
        <h2
          v-else
          class="text-xl font-semibold my-2"
        >
          Something went wrong
        </h2>
        <img
          src="/BokoblinError.png"
          alt="Bokoblin Error"
          class="max-w-xl"
        >
        <p class="text-center text-sm">
          Art by TsunamiCoRyan
        </p>
      </main>
      <AppFooter />
    </div>
  </div>
</template>
<style>
@tailwind base;
@tailwind components;
@tailwind utilities;
body {
    @apply dark:bg-gray-900;
    @apply dark:text-white;
}

</style>
  