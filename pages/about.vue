<script setup lang="ts">
useSeoMeta({
  title: 'About - Bokoblin',
})
useServerSeoMeta({
  description: `Bokoblin, archived data of the last 11 years of Kinstone-operated charity marathons.`,
  ogTitle: 'About - Bokoblin',
  ogDescription: `Bokoblin, archived data of the last 11 years of Kinstone-operated charity marathons.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <div class="m-3 mx-auto">
      <h1 class="text-3xl">
        Bokoblin.com
      </h1>
      <p>Archived data of the last 11 years of Kinstone-operated charity marathons</p>
      <p>This site is community-run and is <em>not</em> affiliated with Kinstone, LLC. or its properties, including but not limited to Zeldathon, Parallel Worlds, Side Quest, and Piece of Heart</p>
      <h2 class="text-2xl my-3">
        Data Removal Request
      </h2>
      <p>
        If you are listed on this website and wish to be removed, contact us at <a href="mailto:dataremoval@bokoblin.com">dataremoval@bokoblin.com</a>
      </p>
      <h2 class="text-2xl my-3">
        Credits
      </h2>
      <p>
        <b>Development:</b> Stone (@ngiano - github)
      </p>
      <p>
        <b>Design help:</b> dark
      </p>
      <p>
        <b>Data Collection &amp; Archiving:</b> Tylinos, dark &amp; our editors at The Doc Team
      </p>
      <p>
        <b>API Help:</b> ArcticLight
      </p>
      <h2 class="text-2xl my-3">
        Special Thanks
      </h2>
      <p>
        <b>0rganics</b> for maintaining donation graphs and legacy donation data
      </p>
      <p>
        <b>All editors, past and present</b> for keeping the legacy of these marathons alive
      </p>
      <p>
        <b>Kinstone Team</b> for creating amazing marathons
      </p>
      <p class="my-5">
        <nuxt-link
          to="/support"
          class="text-blue-400 hover:underline hover:text-blue-500"
        >
          Support Bokoblin
        </nuxt-link>
      </p>
    </div>
  </div>
</template>
