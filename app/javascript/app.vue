<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import StageIndexPage from './StageIndexPage.vue'
import StageDetailPage from './StageDetailPage.vue'

const router = new VueRouter({
  routes: [
    { path: '/',
      component: StageIndexPage },
    { path: '/stage/:id(\\d+)',
      name: 'StageDetailPage',
      component: StageDetailPage }
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>
