<script setup lang="ts">
import { Segment, Runner } from '@/lib/models/api'

const props = defineProps({
  data: {
    type: Object as PropType<Segment>,
    required: true
  }
})
const hosts = ref<Runner[]>([])
const commentary = ref<Runner[]>([])
const players = ref<Runner[]>([])
props.data.runners.forEach((runner: Runner) => {
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
</script>
<template>
  <div
    class="bg-gray-100 hover:bg-slate-100 dark:bg-slate-800 hover:dark:bg-slate-700 shadow-sm border dark:border-gray-600 rounded-md transition-all grid grid-cols-2 sm:grid-cols-4 min-h-[115px]"
    :style="`border-right-color: #${props.data.marathon?.color ?? 'unset'}; border-right-width: ${props.data.marathon ? '4px' : '1px'};`"
  >
    <div class="flex flex-col col-span-3 flex-1 pl-2 pt-2">
      <div class="text-sm">
        {{ new Date(props.data.start_time).toLocaleString() }}
      </div>
      <nuxt-link
        :to="`/segment/${props.data.id}`"
        class="flex-1 flex items-center"
      >
        <div class="text-2xl font-semibold">
          {{ props.data.game?.title ?? "Untitled Game" }}
        </div>
      </nuxt-link>
      <div class="text-sm dark:text-gray-400">
        {{ props.data.modifier }}
      </div>
      <nuxt-link
        v-if="props.data.marathon"
        :to="`/marathon/${props.data.marathon.id}`"
      >
        @ {{ props.data.marathon.full_name }}
      </nuxt-link>
    </div>
    <div class="grid grid-cols-3 sm:flex sm:flex-col text-gray-400 items-end justify-around col-span-2 sm:col-span-1 pr-2 pt-2">
      <div
        class="flex items-center justify-center sm:justify-end gap-1"
      >
        <Icon
          name="bx:stopwatch"
          size="1.2rem"
        />
        {{ toTimestamp(props.data.start_time, props.data.end_time) }}
      </div>
      <div
        class="flex items-center justify-center sm:justify-end gap-1"
      >
        <Icon
          name="clarity:dollar-bill-solid"
          size="1.2rem"
        />
        {{ toUSD(props.data.raised ?? 0) }}
      </div>
      <a
        v-if="props.data.vod"
        ref="noopener"
        :href="`https://www.youtube.com/watch?v=${ props.data.vod }${ props.data.time_offset ? `&t=${props.data.time_offset}` : '' }`"
        target="_blank"
        class="flex items-center justify-center sm:justify-end gap-1"
      >
        <Icon
          name="mdi:youtube"
          size="1.2rem"
        />
        Watch
      </a>
    </div>
    <div
      v-if="props.data.runners.length > 0"
      class="col-span-4 bg-gray-50 dark:bg-gray-800 border-t divide-y divide-gray-200 dark:divide-gray-700 border-t-gray-200 dark:border-t-gray-700 mt-1 rounded-b-md text-gray-800 dark:text-gray-300 text-sm"
    >
      <div
        v-if="(commentary.length > 0 || players.length > 0) && hosts.length > 0"
        class="grid grid-cols-[auto,1fr] gap-1 w-full py-1 px-2"
      >
        <div
          :title="'Host' + (hosts.length > 1 ? 's':'')"
        >
          <Icon
            name="tabler:broadcast"
          />
        </div>
        <div class="flex flex-wrap">
          <div
            v-for="(runner,index) in hosts"
            :key="runner.attendee.id"
          >
            <template
              v-if="runner.attendee.rank !== '2'"
            >
              <nuxt-link
                :to="'/attendee/'+runner.attendee.id"
                class="unstyle"
              >
                {{ runner.attendee.name }}
              </nuxt-link>
              <span v-if="(index+1) !== hosts.length">,&nbsp;</span>
            </template>
            <span
              v-else
              class="unstyle"
            >
              {{ runner.attendee.name }}<span v-if="(index+1) !== hosts.length">,&nbsp;</span>
            </span>
          </div>
        </div>
      </div>
      <div
        v-if="(commentary.length > 0 || hosts.length > 0) && players.length > 0"
        class="grid grid-cols-[auto,1fr] gap-1 w-full py-1 px-2"
      >
        <div :title="'Participant' + (players.length > 1 ? 's':'')">
          <Icon name="mdi:controller-classic" />
        </div>
        <div class="flex flex-wrap">
          <div
            v-for="(runner,index) in players"
            :key="runner.attendee.id"
          >
            <template
              v-if="runner.attendee.rank !== '2'"
            >
              <nuxt-link
                :to="'/attendee/'+runner.attendee.id"
                class="unstyle"
              >
                {{ runner.attendee.name }}
              </nuxt-link>
              <span v-if="(index+1) !== players.length">,&nbsp;</span>
            </template>
            <span
              v-else
              class="unstyle"
            >
              {{ runner.attendee.name }}<span v-if="(index+1) !== players.length">,&nbsp;</span>
            </span>
          </div>
        </div>
      </div>
      <div
        v-if="(hosts.length > 0 || players.length > 0) && commentary.length > 0"
        class="grid grid-cols-[auto,1fr] gap-1 w-full py-1 px-2"
      >
        <div
          :title="'Commentator' + (commentary.length > 1 ? 's':'')"
        >
          <Icon name="material-symbols:mic" />
        </div>
        <div class="flex flex-wrap">
          <div
            v-for="(runner,index) in commentary"
            :key="runner.attendee.id"
          >
            <template
              v-if="runner.attendee.rank !== '2'"
            >
              <nuxt-link
                :to="'/attendee/'+runner.attendee.id"
                class="unstyle"
              >
                {{ runner.attendee.name }}
              </nuxt-link>
              <span v-if="(index+1) !== commentary.length">,&nbsp;</span>
            </template>
            <span
              v-else
              class="unstyle"
            >
              {{ runner.attendee.name }}<span v-if="(index+1) !== commentary.length">,&nbsp;</span>
            </span>
          </div>
        </div>
      </div>
      <div
        v-if="((hosts.length == 0 && players.length == 0) || (commentary.length == 0 && hosts.length == 0) || (players.length == 0 && commentary.length == 0) || (commentary.length == 0 && players.length == 0)) && (commentary.length > 0 || players.length > 0 || hosts.length > 0)"
        class="grid grid-cols-[auto,1fr] gap-1 w-full py-1 px-2"
      >
        <div
          :title="'Runner' + (props.data.runners.length > 1 ? 's':'')"
        >
          <Icon name="mdi:controller-classic" />
        </div>
        <div class="flex flex-wrap">
          <div
            v-for="(runner,index) in props.data.runners"
            :key="runner.attendee.id"
          >
            <template
              v-if="runner.attendee.rank !== '2'"
            >
              <nuxt-link
                :to="'/attendee/'+runner.attendee.id"
                class="unstyle"
              >
                {{ runner.attendee.name }}
              </nuxt-link>
              <span v-if="(index+1) !== props.data.runners.length">,&nbsp;</span>
            </template>
            <template
              v-else
            >
              {{ runner.attendee.name }}<span v-if="(index+1) !== props.data.runners.length">,&nbsp;</span>
            </template>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>@/utils
@/models/api