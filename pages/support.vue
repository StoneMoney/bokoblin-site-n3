<script setup lang="ts">
useSeoMeta({
  title: 'Support - Bokoblin',
})
useServerSeoMeta({
  description: `Bokoblin, archived data of Zeldathon-affiliated charity marathons.`,
  ogTitle: 'Support - Bokoblin',
  ogDescription: `Bokoblin, archived data of Zeldathon-affiliated charity marathons.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <div class="m-3 mx-auto max-w-xl">
      <h1 class="text-3xl mb-4">
        Support Bokoblin
      </h1>
      <h3 class="text-2xl">
        Patreon
      </h3>
      <p>
        Bokoblin is hosted out-of-pocket by StoneMoney, if you wish to support the project by chipping in for hosting, domain, and server costs you can do so on their Patreon page. Some goals have been set up as well, should they be met, Bokoblin can expand to accomodate even more!
      </p>
      <p>
        We also have a merch store available, get your very own Bokoskull shirt or hoodie! Approximately $5-6 from each sale goes to server costs (the remainder is manufacturing costs)
      </p>
      <div class="flex">
        <nuxt-link
          href="https://www.patreon.com/stonemoney"
          target="_blank"
          rel="noopener"
          class="mr-1 my-2 p-2 bg-orange-400 hover:bg-orange-500 rounded font-semibold text-white"
        >
          <Icon name="mdi:patreon" /> Support on Patreon
        </nuxt-link>
        <nuxt-link
          href="https://shop.bokoblin.com/"
          target="_blank"
          rel="noopener"
          class="mr-1 my-2 p-2 bg-red-400 hover:bg-red-500 rounded font-semibold text-white"
        >
          <Icon name="mdi:tshirt-crew" /> Purchase Merch
        </nuxt-link>
      </div>
      <h3 class="mt-3 text-2xl">
        Archiver
      </h3>
      <p class="my-2">
        If you would like to assist in archiving data for future events, please join the Doc Team discord!
      </p>
      <nuxt-link
        href="https://discord.gg/bUjNJ9j"
        target="_blank"
        rel="noopener"
        class="mr-1 my-2 p-2 bg-blue-400 hover:bg-blue-500 rounded font-semibold text-white"
      >
        <Icon name="ic:baseline-discord" /> Our Discord
      </nuxt-link>
      <h3 class="mt-3 text-2xl">
        Developer
      </h3>
      <p class="my-2">
        The Bokoblin front-end is open source and welcome to PRs on Github!
      </p>
      <nuxt-link
        href="https://github.com/StoneMoney/bokoblin-site-n3"
        target="_blank"
        rel="noopener"
        class="mr-1 my-2 p-2 bg-gray-400 hover:bg-gray-500 rounded font-semibold text-white"
      >
        <Icon name="mdi:github" /> N3 Github Repo
      </nuxt-link>
      <nuxt-link
        href="https://github.com/StoneMoney/bokoblin-website"
        target="_blank"
        rel="noopener"
        class="mr-1 my-2 p-2 bg-gray-400 hover:bg-gray-500 rounded font-semibold text-white"
      >
        <Icon name="mdi:github" /> Classic Github Repo
      </nuxt-link>
      <h3 class="mt-3 text-2xl">
        Feedback
      </h3>
      <p class="my-2">
        If you have feedback, feel free to send it to <a href="mailto:feedback@stone.money">feedback@stone.money</a> or DM Stone on Discord
      </p>
      <nuxt-link
        href="mailto:feedback@stone.money"
        target="_blank"
        rel="noopener"
        class="mr-1 p-2 bg-gray-400 hover:bg-gray-500 rounded font-semibold text-white"
      >
        <Icon name="material-symbols:mail" /> Email Us!
      </nuxt-link>
    </div>
  </div>
</template>
