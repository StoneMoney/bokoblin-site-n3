<script setup lang="ts">
import { Segment, Runner } from '@/models/api'

const route = useRoute()
const segmentID = route.params.id
const query = gql`
query {
  segment(id: ${segmentID}) {
    id
    game{
      title
      id
    }
    modifier
    runners{
      attendee{
        name
        id
        rank
      }
      rank
    }
    filenames{
      filename
      note
    }
    raised
    start_time
    end_time
    vod
    time_offset
    marathon{
      id
      color
      full_name
      slug
      type
      type_id
      total
      start_date
      stop_date
      playlist
      charity{
        id
        full_name
      }
    }
  }
}
`

const segment = ref<Segment | undefined>()
const hosts = ref<Runner[]>([])
const commentary = ref<Runner[]>([])
const players = ref<Runner[]>([])
type RespondData = {
  segment: Segment
}

const { data } = await useAsyncQuery<RespondData>(query)
if (data.value?.segment) {
  segment.value = data.value.segment

  segment.value.runners.forEach((runner: Runner) => {
    switch (runner.rank) {
      case 0:
        hosts.value.push(runner)
        break
      case 1:
        commentary.value.push(runner)
        break
      case 2:
        players.value.push(runner)
        break
    }
  })
}
if(segment.value) {
  useSeoMeta({
    title: `${segment.value.game!.title} @ ${segment.value.marathon!.slug} - Bokoblin`,
  })
  useServerSeoMeta({
    description: `Archive data for ${segment.value.game!.title} at ${segment.value.marathon!.full_name} which raised ${toUSD(segment.value.raised!)} for ${segment.value.marathon!.charity.full_name}.`,
    ogTitle: `${segment.value.game!.title} @ ${segment.value.marathon!.full_name} - Bokoblin`,
    ogDescription: `Archive data for ${segment.value.game!.title} at ${segment.value.marathon!.full_name} which raised ${toUSD(segment.value.raised!)} for ${segment.value.marathon!.charity.full_name}.`,
    themeColor: `#${segment.value.marathon!.color}`,
    ogVideo: `https://youtube.com/embed/${segment.value.vod}?start=${segment.value.time_offset}s${segment.value.marathon ? '&list='+segment.value.marathon.playlist : ''}`,
    ogVideoUrl: `http://youtube.com/embed/${segment.value.vod}?t=${segment.value.time_offset}s${segment.value.marathon ? '&list='+segment.value.marathon.playlist : ''}`,
    ogVideoSecureUrl: `https://youtube.com/embed/${segment.value.vod}?t=${segment.value.time_offset}s${segment.value.marathon ? '&list='+segment.value.marathon.playlist : ''}`,
    ogVideoWidth: '1280',
    ogVideoHeight: '720',
    ogType: 'video.other',
    ogImage: `https://i3.ytimg.com/vi/${segment.value.vod}/maxresdefault.jpg`,
    ogImageUrl: `http://i3.ytimg.com/vi/${segment.value.vod}/maxresdefault.jpg`,
    ogImageSecureUrl: `https://i3.ytimg.com/vi/${segment.value.vod}/maxresdefault.jpg`,
    ogImageWidth: '1280',
    ogImageHeight: '720',
    ogImageType: 'image/jpeg',
    twitterCard: 'player',
    twitterSite: '@bokoblindocs',
    twitterPlayer: `https://youtube.com/embed/${segment.value.vod}?start=${segment.value.time_offset}s${segment.value.marathon ? '&list='+segment.value.marathon.playlist : ''}`,
    twitterPlayerWidth: '1280',
    twitterPlayerHeight: '720',
    twitterImage: `https://i3.ytimg.com/vi/${segment.value.vod}/maxresdefault.jpg`,
  })
}
</script>
<template>
  <div v-if="segment">
    <div class="text-sm text-gray-500 text-center">
      Segment &sharp;{{ segment.id }}
    </div>
    <div
      class="grid md:grid-cols-[1fr,auto,1fr] gap-2 my-3"
    >
      <div class="flex items-center justify-center md:justify-end">
        <nuxt-link
          :to="`/game/${segment.game?.id}`"
          class="text-3xl px-3 py-1 text-center font-bold bg-slate-500 dark:bg-slate-700 text-white transition-all group rounded shadow flex justify-center items-center"
        >
          {{ segment.game?.title }}
          <div class="w-0 overflow-hidden ml-1 group-hover:w-9 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
            {{ segment.game?.id }}
          </div>
        </nuxt-link>
      </div>
      <div class="flex items-center justify-center">
        <span class="text-3xl mx-2">@</span>
      </div>
      <div class="flex items-center justify-center md:justify-start">
        <nuxt-link
          :to="`/marathon/${segment.marathon?.id}`"
          class="text-3xl px-3 py-1 text-center font-bold text-white transition-all group rounded shadow flex justify-center items-center"
          :style="`background-color: #${segment.marathon?.color ?? '000000'};`"
        >
          {{ segment.marathon?.full_name }}
          <div class="w-0 overflow-hidden ml-1 group-hover:w-10 transition-all delay-75 text-sm font-mono bg-black/20 rounded tracking-wider">
            {{ segment.marathon?.id }}
          </div>
        </nuxt-link>
      </div>
    </div>
    <h2 class="text-3xl mb-3 text-center font-bold">
      {{ segment.modifier }}
    </h2>
    <h2 class="text-2xl mb-3 text-center font-bold">
      {{ toReadableDate(segment.start_time) }}
    </h2>
    <div class="grid grid-cols-1 gap-2 sm:grid-cols-2 md:grid-cols-3">
      <div>
        <h3 class="text-center text-xl my-3.5">
          Marathon
        </h3>
        <marathon-card :data="segment.marathon" />
        <h3 class="text-center text-xl my-3.5">
          Stats
        </h3>
        <div class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600">
          <div class="p-2">
            <Icon
              name="clarity:dollar-bill-solid"
              size="1.2rem"
            />
            {{ toUSD(segment.raised ?? 0) }} raised ({{ toUSD((segment.raised ?? 0) / getDurationNumberal(segment.start_time, segment.end_time)) }}/hr)
          </div>
          <div class="p-2">
            <Icon
              name="bx:stopwatch"
              size="1.2rem"
            />
            {{ toTimestamp(segment.start_time, segment.end_time) }} duration
          </div>
          <div class="p-2">
            <Icon
              name="material-symbols:line-start-circle-outline"
              size="1.2rem"
            />
            {{ new Date(segment.start_time).toLocaleString() }} ({{ toTimestamp(segment.marathon?.start_date ?? new Date(), segment.start_time) }})
          </div>
          <div class="p-2">
            <Icon
              name="material-symbols:line-end-square"
              size="1.2rem"
            />
            {{ new Date(segment.end_time).toLocaleString() }} ({{ toTimestamp(segment.marathon?.start_date ?? new Date(), segment.end_time) }})
          </div>
        </div>
        <h3 class="text-center text-xl my-3.5">
          Participants
        </h3>
        <div
          v-if="segment.runners.length > 0"
          class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600"
        >
          <div
            v-for="host in hosts"
            :key="host.attendee.id"
            class="p-2"
          >
            <nuxt-link
              :to="host.attendee.rank !== '2' ? `/attendee/${host.attendee.id}` : ''"
            >
              <Icon
                name="tabler:broadcast"
                title="Host"
              />
              {{ host.attendee.name }}
            </nuxt-link>
          </div>
          <div
            v-for="commentator in commentary"
            :key="commentator.attendee.id"
            class="p-2"
          >
            <nuxt-link
              :to="commentator.attendee.rank !== '2' ? `/attendee/${commentator.attendee.id}` : ''"
            >
              <Icon
                name="material-symbols:mic"
                title="Commentary"
              />
              {{ commentator.attendee.name }}
            </nuxt-link>
          </div>
          <div
            v-for="player in players"
            :key="player.attendee.id"
            class="p-2"
          >
            <nuxt-link
              :to="player.attendee.rank !== '2' ? `/attendee/${player.attendee.id}` : ''"
            >
              <Icon
                name="mdi:controller-classic"
                title="Player"
              />
              {{ player.attendee.name }}
            </nuxt-link>
          </div>
        </div>
        <div
          v-else
          class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600 p-2"
        >
          None listed!
        </div>
        <template v-if="segment.filenames.length > 0">
          <h3 class="text-center text-xl my-3.5">
            Filename{{ segment.filenames.length > 1 ? 's':'' }}
          </h3>
          <div
            class="rounded border divide-y dark:bg-slate-800 dark:border-gray-600 dark:divide-gray-600"
          >
            <div
              v-for="filename in segment.filenames"
              :key="`${filename.filename}-${filename.note}`"
              class="p-2"
            >
              {{ filename.filename }}{{ filename.note ? ` (${filename.note})`:'' }}
            </div>
          </div>
        </template>
      </div>
      <div
        v-if="segment.vod"
        class="md:col-span-2"
      >
        <h3 class="text-center text-xl my-3.5">
          Video
        </h3>
        <div class="border rounded-md text-center dark:border-gray-600">
          <client-only
            fallback-tag="span"
            fallback="Loading YouTube Embed..."
          >
            <lite-youtube
              :videoid="segment.vod"
              :params="`modestbranding=1&start=${segment.time_offset}${segment.marathon ? '&list='+segment.marathon.playlist : ''}`"
              class="p-2 mx-auto my-2"
            />
          </client-only>
          <div class=" mb-2">
            <nuxt-link
              class="hover:underline text-blue-500"
              :href="`https://youtube.com/watch?v=${segment.vod}&t=${segment.time_offset}s${segment.marathon ? '&list='+segment.marathon.playlist : ''}`"
            >
              Watch on YouTube
            </nuxt-link>
          </div>
        </div>
      </div>
      <div 
        v-else
        class="md:col-span-2"
      >
        <h3 class="text-center text-xl my-3.5">
          No VOD Available
        </h3>
      </div>
    </div>
  </div>
</template>
