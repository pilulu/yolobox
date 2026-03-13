import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'yolobox',
  description: 'Run AI coding agents in a sandboxed container. Your home directory stays home.',

  head: [
    ['link', { rel: 'icon', href: '/favicon.svg' }],
    ['meta', { property: 'og:title', content: 'yolobox' }],
    ['meta', { property: 'og:description', content: 'Run AI coding agents in a sandboxed container. Your home directory stays home.' }],
    ['meta', { property: 'og:url', content: 'https://yolobox.dev' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
  ],

  appearance: 'dark',
  cleanUrls: true,

  themeConfig: {
    siteTitle: 'yolobox',

    nav: [
      { text: 'Docs', link: '/getting-started' },
      { text: 'Security', link: '/security' },
    ],

    sidebar: [
      {
        text: 'Getting Started',
        items: [
          { text: 'Installation & Setup', link: '/getting-started' },
          { text: 'Commands', link: '/commands' },
          { text: "What's in the Box", link: '/whats-in-the-box' },
        ]
      },
      {
        text: 'Reference',
        items: [
          { text: 'Flags', link: '/flags' },
          { text: 'Configuration', link: '/configuration' },
        ]
      },
      {
        text: 'Advanced',
        items: [
          { text: 'Security Model', link: '/security' },
          { text: 'Customizing the Image', link: '/customizing' },
          { text: 'Contributing', link: '/contributing' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/finbarr/yolobox' }
    ],

    editLink: {
      pattern: 'https://github.com/finbarr/yolobox/edit/master/docs/:path',
      text: 'Edit this page on GitHub'
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright 2025 Finbarr Taylor'
    },

    search: {
      provider: 'local'
    }
  }
})
