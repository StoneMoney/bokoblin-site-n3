<script setup>
const props = defineProps({
  title: {
    type: String,
    default: 'Unknown'
  },
  description: {
    type: String,
    default: 'Description here'
  },
  image: {
    type: String,
    default: '/img/doc-preview-current.png'
  },
  link: {
    type: String,
    default: '#'
  }
})
</script>
<template>
  <nuxt-link
    class="h-48 w-64 flex flex-col group cursor-pointer"
    :to="props.link"
    target="_blank"
  >
    <div class="px-3 pt-1 pb-2 dark:bg-slate-800 bg-slate-50 rounded-t border-t border-l border-r dark:border-gray-600 h-28 overflow-hidden relative flex justify-center">
      <NuxtImg
        :src="props.image"
        :alt="props.title"
        class="group-hover:scale-110 transition w-56 rounded-sm shadow-sm -bottom-9 border border-gray-300 dark:border-gray-700 absolute"
        format="webp"
        width="222"
        height="107"
      />
    </div>
    <div class="px-3 pt-1 pb-2 dark:bg-slate-700 bg-slate-100 rounded-b border dark:border-gray-600 flex-1">
      <div class="text-md font-semibold">
        {{ props.title }}
      </div>
      <p class="text-sm dark:text-slate-300 text-gray-600">
        {{ props.description }}
      </p>
    </div>
  </nuxt-link>
</template>
