<template>
  <v-app>
    <router-view></router-view>
  </v-app>
</template>

<script>
import Vue       from 'vue'
import VueRouter from 'vue-router'

import StageMain     from './StageMain.vue'
import UserPage      from './UserPage.vue'
import CustomerIndex  from './CustomerIndex.vue'

const router = new VueRouter({
  routes: [
    {
      path: `/`,
      component: UserPage
    },{
      path: '/stages/:id(\\d+)',
      name: 'StageMain',
      component: StageMain
    },{
      path: '/customers',
      name: 'CustomerIndex',
      component: CustomerIndex
    },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>
