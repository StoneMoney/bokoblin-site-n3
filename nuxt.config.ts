// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    "@nuxtjs/eslint-module",
    // '@nuxtjs/algolia',
    "@nuxtjs/apollo",
    "@nuxt/image",
    "@nuxtjs/tailwindcss",
    "nuxt-headlessui",
    "nuxt-icon",
    "nuxt-graphql-server",
    "@vite-pwa/nuxt",
  ],
  css: ["lite-youtube-embed/src/lite-yt-embed.css"],
  plugins: ["~/plugins/youtube.client.js"],
  graphqlServer: {
    schema: "./database/graphql/models/schema.gql",
    url: "/api/graphql",
  },
  app: {
    pageTransition: { name: "page", mode: "out-in" },
    head: {
      title: "Bokoblin",
      charset: "utf-8",
      viewport: "width=device-width, initial-scale=1",
      htmlAttrs: { lang: "en" },
      link: [
        {rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png'},
        {rel: 'icon', type: 'image/png', sizes: '32x32', href: '/favicon-32x32.png'},
        {rel: 'icon', type: 'image/png', sizes: '16x16', href: '/favicon-16x16.png'},
        {rel: 'manifest', href: '/site.webmanifest'},
        {rel: 'mask-icon', href: '/safari-pinned-tab.svg', color: '#ff5959'},
      ],
      meta: [
        {name: 'msapplication-TileColor', content: '#ff5959'},
      ]
    },
  },
  // algolia: {
  //   apiKey: process.env.ALGOLIA_SEARCH_API_KEY,
  //   applicationId: process.env.ALGOLIA_APPLICATION_ID,
  //   instantSearch: {
  //     theme: 'algolia'
  //   }
  // },
  apollo: {
    clients: {
      default: {
        httpEndpoint: `${process.env.BASE_URL}/api/graphql`,
      },
    },
  },
  pwa: {
    manifest: {
      name: 'Bokoblin Archives',
      short_name: 'Bokoblin',
      description: 'Bokoblin, archived data of Zeldathon-affiliated charity marathons',
      display: 'standalone',
      background_color: '#ffffff',
      theme_color: '#343a40',
      lang: 'en',
    },
    workbox: {
      navigateFallback: '/',
    },
    devOptions: {
      enabled: true,
      type: 'module'
    }
  },
  runtimeConfig: {
    SOUNDS_KEY: process.env.SOUNDS_KEY,
    public: {
      baseUrl: process.env.BASE_URL,
      graphqlBaseUrl: process.env.GRAPHQL_BASE_URL || process.env.BASE_URL,
    },
  },
  typescript: {
    tsConfig: {
      compilerOptions: {
        baseUrl: ".",
        paths: {
          "@": ["."],
          "@/*": ["./*"],
        },
      },
    },
  },
});
