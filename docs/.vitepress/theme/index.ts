import { h } from 'vue'
import DefaultTheme from 'vitepress/theme'
import HomeContent from './components/HomeContent.vue'
import AsciiLogo from './components/AsciiLogo.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
      'home-hero-info-before': () => h(AsciiLogo),
    })
  },
  enhanceApp({ app }) {
    app.component('HomeContent', HomeContent)
  }
}
