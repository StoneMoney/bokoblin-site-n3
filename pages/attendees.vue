<script setup lang="ts">
import type { Attendee } from '@/models/api'
const query = gql`
  query {
    attendees {
      name
      rank
      id
    }
  }
  `
const attendees: Ref<Attendee[]> = ref<Attendee[]>([])
type RespondData = {
    attendees: Attendee[]
}
const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.attendees) {
  attendees.value = data.value.attendees
}
useSeoMeta({
  title: 'People - Bokoblin',
})
useServerSeoMeta({
  description: `Archive data for ${attendees.value.length} people.`,
  ogTitle: 'People - Bokoblin',
  ogDescription: `Archive data for ${attendees.value.length} people.`,
  themeColor: '#FF5959'
})
</script>
<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      People ({{ attendees.length }})
    </h1>
    <div
      class="md:grid md:grid-cols-4 flex flex-wrap gap-2 justify-center"
    >
      <div>
        <div class="text-xl2 text-center font-semibold">
          Active ({{ attendees.filter(a => a.rank === '1').length }})
        </div>
        <div class="rounded border grid divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <nuxt-link
            v-for="attendee in attendees.filter(a => a.rank === '1').sort((a, b) => a.name.localeCompare(b.name))"
            :key="attendee.id"
            :to="`/attendee/${attendee.id}`"
            class="p-2"
          >
            {{ attendee.name }}
          </nuxt-link>
        </div>
      </div>
      <div>
        <div class="text-xl2 text-center font-semibold">
          Guest ({{ attendees.filter(a => a.rank === '3').length }})
        </div>
        <div class="rounded border grid divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <nuxt-link
            v-for="attendee in attendees.filter(a => a.rank === '3').sort((a, b) => a.name.localeCompare(b.name))"
            :key="attendee.id"
            :to="`/attendee/${attendee.id}`"
            class="p-2"
          >
            {{ attendee.name }}
          </nuxt-link>
        </div>
      </div>
      <div>
        <div class="text-xl2 text-center font-semibold">
          Charity Rep ({{ attendees.filter(a => a.rank === '4').length }})
        </div>
        <div class="rounded border grid divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <nuxt-link
            v-for="attendee in attendees.filter(a => a.rank === '4').sort((a, b) => a.name.localeCompare(b.name))"
            :key="attendee.id"
            :to="`/attendee/${attendee.id}`"
            class="p-2"
          >
            {{ attendee.name }}
          </nuxt-link>
        </div>
      </div>
      <div>
        <div class="text-xl2 text-center font-semibold">
          Misc ({{ attendees.filter(a => a.rank === '5').length }})
        </div>
        <div class="rounded border grid divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <nuxt-link
            v-for="attendee in attendees.filter(a => a.rank === '5').sort((a, b) => a.name.localeCompare(b.name))"
            :key="attendee.id"
            :to="`/attendee/${attendee.id}`"
            class="p-2"
          >
            {{ attendee.name }}
          </nuxt-link>
        </div>
      </div>
    </div>
    <h2 class="text-sm text-center my-2 opacity-75">
      {{ attendees.filter(a => a.rank === '2').length }} people are unlisted
    </h2>
  </div>
</template>
