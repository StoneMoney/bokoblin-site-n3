<script setup lang="ts">
const docs = [
  {
    title: 'Current Event',
    description: 'Stats tracking and event log for the most recent marathon, as well as active secret sounds.',
    image: 'img/doc-preview-current.png',
    link: 'https://doc.bokoblin.com'
  },
  {
    title: 'Archive',
    description: 'Overall information for each marathon, game runners, filenames, rankings, and records',
    image: 'img/doc-preview-archive.png',
    link: 'https://docs.google.com/spreadsheets/d/1mAhSDgMUySGB4rxwFX7DpGrnChZrUs58TbvKAX3fCto/'
  },
  {
    title: 'Zeldathon Logs',
    description: 'Stat tracking and event log for all prior Zeldathon events, and secret sound history.',
    image: 'img/doc-preview-logs.png',
    link: 'https://docs.google.com/spreadsheets/d/1z2Y_unhykpD4jmpKgRrXagad42Jl7EFRNm7JfqtQQ7c/'
  }
]
const affiliates = [
  {
    title: 'Direct Relief Colosseum',
    image: 'img/affiliates/colosseum.webp',
    links: [
      {
        name: 'Primary',
        url: 'https://docs.google.com/spreadsheets/d/1i4NW6HuZBm-3ZosP741S4ymWVN9sWjW_2cxADFJpYuI/'
      }
    ],
    invert: true
  },
  {
    title: 'Pokethon',
    image: 'img/affiliates/pokethon.png',
    links: [
      {
        name: 'Primary',
        url: 'https://docs.google.com/spreadsheets/d/1yLRGQeHiNAPo3an9Rrs40ntA_CLGy_RvkJ8NHWDy51E/'
      },
      {
        name: 'Archive',
        url: 'https://docs.google.com/spreadsheets/d/1b9VpCmjdRXA3G5wNDFWOYgVhTf2itJAh2SCFXJjx1kM/'
      }
    ],
    invert: true
  },
  {
    title: 'Metroid Marathon',
    image: 'img/affiliates/metroid.gif',
    imgWidth: 150,
    links: [
      {
        name: 'Primary',
        url: 'https://docs.google.com/spreadsheets/d/1aaKsYgaFz2lobsiNomphpMA2np6_OuUELNNjYDynji0/'
      }
    ]
  },
  {
    title: 'Kirbython',
    image: 'img/affiliates/kirbython.png',
    links: [
      {
        name: 'Primary',
        url: 'https://docs.google.com/spreadsheets/d/1ZMUBYL2WOARIXHSQooDJu5F6qk_uJWzlcVwP7gkwyR8/'
      }
    ]
  },
  {
    title: 'Minikit Marathon',
    image: 'img/affiliates/minikit.jpg',
    links: [
      {
        name: 'Primary',
        url: 'https://docs.google.com/spreadsheets/d/1uB59AgHYvESTV4KfoUoAQyGgRlZXBBIy_q2mh3VpVPQ/'
      }
    ]
  }
]
useSeoMeta({
  title: 'Bokoblin',
})
useServerSeoMeta({
  description: `Bokoblin, archived data of Kinstone-operated charity marathons.`,
  ogTitle: 'Bokoblin',
  ogDescription: `Bokoblin, archived data of Kinstone-operated charity marathons.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div class="flex flex-col justify-center items-center my-12">
    <NuxtImg
      src="/img/bokoblin.svg"
      alt="Bokoblin"
      width="575"
      height="150"
      sizes="sm:350 md:475 lg:575"
    />
    <h1 class="text-3xl font-bold my-2">
      Kinstone Archives
    </h1>
    <div class="flex flex-wrap justify-center">
      <span class="p-3">Find...</span>
      <NuxtLink to="/marathons">
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 p-3 rounded">
          Marathons
        </div>
      </NuxtLink>
      <NuxtLink to="/sounds">
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 p-3 rounded">
          Sounds
        </div>
      </NuxtLink>
      <NuxtLink to="/games">
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 p-3 rounded">
          Games
        </div>
      </NuxtLink>
      <NuxtLink to="/attendees">
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 p-3 rounded">
          People
        </div>
      </NuxtLink>
      <NuxtLink to="/causes">
        <div class="hover:bg-slate-100 dark:hover:bg-gray-800 p-3 rounded">
          Causes
        </div>
      </NuxtLink>
    </div>
    <h2 class="text-xl my-3.5">
      Or view the source documents...
    </h2>
    <div class="flex justify-center gap-2 flex-wrap">
      <doc-card
        v-for="doc in docs"
        :key="doc.title"
        :description="doc.description"
        :title="doc.title"
        :image="doc.image"
        :link="doc.link"
        class="hover:shadow-lg shadow-none transition-shadow"
      />
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-3 w-max gap-3 p-3">
      <div class="dark:bg-slate-700 bg-slate-100 rounded border dark:border-gray-600 flex-1 flex justify-center divide-x dark:divide-gray-600">
        <nuxt-link
          to="https://docs.google.com/spreadsheets/d/1IMKG7Zy0mcIVN1K7nMctboFg4Lr5csNlgtjqyfv9o7Y/"
          class="py-2 w-full text-center"
          target="_blank"
        >
          <span
            :class="`px-3 pt-1 pb-2 text-md font-semibold text-blue-500`"
          >
            Piece of Heart
          </span>
        </nuxt-link>
      </div>
      <div class="dark:bg-slate-700 bg-slate-100 rounded border dark:border-gray-600 flex-1 flex justify-center divide-x dark:divide-gray-600">
        <nuxt-link
          to="https://docs.google.com/spreadsheets/d/1gTZwLgvd6H9ZCM-ZIieLYbkHX0jdXyglmisF2VtKpnE/"
          class="py-2 w-full text-center"
          target="_blank"
        >
          <span
            :class="`px-3 pt-1 pb-2 text-md font-semibold text-blue-500`"
          >
            Side Quest
          </span>
        </nuxt-link>
      </div>
      <div class="dark:bg-slate-700 bg-slate-100 rounded border dark:border-gray-600 flex-1 flex justify-center divide-x dark:divide-gray-600">
        <nuxt-link
          to="https://docs.google.com/spreadsheets/d/1IMKG7Zy0mcIVN1K7nMctboFg4Lr5csNlgtjqyfv9o7Y/"
          class="py-2 w-full text-center"
          target="_blank"
        >
          <span
            :class="`px-3 pt-1 pb-2 text-md font-semibold text-blue-500`"
          >
            Graphs
          </span>
        </nuxt-link>
      </div>
    </div>
    <h2 class="text-xl my-3.5">
      Other affiliated documents...
    </h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-2 max-w-3xl">
      <affiliate-card
        v-for="affiliate in affiliates"
        :key="affiliate.title"
        :title="affiliate.title"
        :links="affiliate.links"
        :image="affiliate.image"
        :invert="affiliate.invert"
        :img-width="affiliate.imgWidth ?? 200"
        class="hover:shadow-lg shadow-none transition-shadow"
      />
    </div>
  </div>
</template>
