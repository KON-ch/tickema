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
import CustomerNotPage from './CustomerNotPage.vue'

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
    { path: '/customers/not/:id(\\d+)',
      name: 'CustomerNotPage',
      component: CustomerNotPage },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>
