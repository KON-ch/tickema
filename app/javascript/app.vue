<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue             from 'vue'
import VueRouter       from 'vue-router'

import StageIndexPage  from './StageIndexPage.vue'
import StageDetailPage from './StageDetailPage.vue'
import StageNewPage    from './StageNewPage.vue'
import StageEditPage   from './StageEditPage.vue'
import ScheduleNewPage from './ScheduleNewPage.vue'

const router = new VueRouter({
  routes: [
    { path: '/',
      component: StageIndexPage  },
    { path: '/stages/:id(\\d+)',
      name: 'StageDetailPage',
      component: StageDetailPage },
    { path: '/stages/new',
      name: 'StageNewPage',
      component: StageNewPage    },
    { path: '/stages/:id(\\d+)/edit',
      name: 'StageEditPage',
      component: StageEditPage   },
    { path: '/schedules/:id(\\d+)',
      name: 'ScheduleNewPage',
      component: ScheduleNewPage },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>
