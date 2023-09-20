<template>
  <div>
    <VitePwaManifest />
    <NuxtLoadingIndicator color="#ff5959" />
    <AppHeader class="sticky top-0 bg-white dark:bg-slate-900 z-[9999]" />
    <div class="flex items-center flex-col">
      <main class="my-2 px-2 max-w-6xl w-full">
        <NuxtPage />
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

.page-enter-active,
.page-leave-active {
  transition: opacity 0.35s;
}
.page-enter,
.page-leave-to {
  opacity: 0;
}

</style>
