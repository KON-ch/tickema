<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue             from 'vue'
import VueRouter       from 'vue-router'

import UserPage        from './UserPage.vue'
import StageDetailPage from './StageDetailPage.vue'
import CustomerIndexPage from './CustomerIndexPage.vue'

const router = new VueRouter({
  routes: [
    { path: `/`,
      component: UserPage        },
    { path: '/stages/:id(\\d+)',
      name: 'StageDetailPage',
      component: StageDetailPage },
    { path: '/customers/:id(\\d+)',
      name: 'CustomerIndexPage',
      component: CustomerIndexPage },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>
