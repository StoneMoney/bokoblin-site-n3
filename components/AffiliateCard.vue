<script setup>
const props = defineProps({
  title: {
    type: String,
    default: 'Unknown'
  },
  links: {
    type: Array,
    default: () => {
      return [{
        name: 'Unknown',
        url: '#'
      }]
    }
  },
  image: {
    type: String,
    default: 'img/doc-preview-current.png'
  },
  imgWidth: {
    type: Number,
    default: 200
  },
  invert: {
    type: Boolean,
    default: false
  }
})
</script>
<template>
  <div class="flex flex-col group">
    <div class="px-3 pt-1 pb-2 dark:bg-slate-800 bg-slate-50 rounded-t border-t border-l border-r dark:border-gray-600 h-28 overflow-hidden relative flex justify-center">
      <div
        class="m-3 flex justify-center items-center"
      >
        <NuxtImg
          :src="props.image"
          :alt="props.title"
          :class="`group-hover:scale-105 transition max-w-full max-h-full ${props.invert ? 'dark:invert' : ''}`"
          format="webp"
          :width="props.imgWidth"
        />
      </div>
    </div>
    <div class="dark:bg-slate-700 bg-slate-100 rounded-b border dark:border-gray-600 flex-1 flex justify-center divide-x dark:divide-gray-600">
      <nuxt-link
        v-for="link in props.links"
        :key="link.name"
        class="py-2 w-full text-center"
        :href="link.url"
        target="_blank"
      >
        <span
          :class="`px-3 pt-1 pb-2 text-md font-semibold text-blue-500`"
        >
          {{ links.length == 1 ? props.title : link.name }}
        </span>
      </nuxt-link>
    </div>
  </div>
</template>
