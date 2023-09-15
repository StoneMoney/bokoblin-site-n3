<template>
  <div>
    <h1 class="text-3xl my-3 text-center font-bold">
      Bokoblin Extension
    </h1>
    <p class="text-center">
      A browser extension for use during Kinstone marathons!
    </p>
    <div class="flex justify-center gap-2 m-3">
      <div class="my-3">
        <nuxt-link to="https://chrome.google.com/webstore/detail/zeldathon-donation-compan/lpkoibgmidgpjhnlhnnccgekdiikpggi?hl=en&authuser=0">
          <span class="rounded bg-[#26a69a] hover:bg-green-400 text-white p-2 whitespace-pre flex items-center">
            <Icon name="ri:chrome-fill" />
            <Icon name="ri:edge-new-fill" />
            Chromium Browsers
          </span>
        </nuxt-link>
      </div>
      <div class="my-3">
        <nuxt-link to="https://addons.mozilla.org/en-US/firefox/addon/bokoblin/">
          <span class="rounded bg-[#ff9800] hover:bg-orange-400 text-white p-2 whitespace-pre flex items-center">
            <Icon name="ri:firefox-fill" />
            Mozilla Firefox
          </span>
        </nuxt-link>
      </div>
    </div>

    <h2 class="text-2xl my-3 text-center font-bold">
      Features
    </h2>
    <div class="grid md:grid-cols-4 sm:grid-cols-2 grid-cols-1 gap-3">
      <div>
        <div class="text-lg font-bold">
          Quick View
        </div>
        <div>
          Check your donation contribution, and the marathon total by clicking the bokoblin skull
        </div>
      </div>
      <div>
        <div class="text-lg font-bold">
          Budget Alerts
        </div>
        <div>
          See an on-page alert with budget reminders.
        </div>
      </div>
      <div>
        <div class="text-lg font-bold">
          Tier Checking
        </div>
        <div>
          Track your donations (per name) and see progress twoard the next donor tier
        </div>
      </div>
      <div>
        <div class="text-lg font-bold">
          Attendie Chat Badges
        </div>
        <div>
          Highlight Kinstone team members in chat with a special triforce badge next to their username.
        </div>
      </div>
    </div>
  </div>
</template>
  