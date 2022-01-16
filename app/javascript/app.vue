<template>
  <v-app>
    <router-view></router-view>
  </v-app>
</template>

<script>
import Vue       from 'vue'
import VueRouter from 'vue-router'
import store      from "./packs/store"
import UserPage      from './UserPage.vue'
import StageMain     from './StageMain.vue'

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
      component: () => import('./CustomerIndex.vue')
    },{
      path: '*',
      redirect: '/'
    }
  ]
})

Vue.use(VueRouter)

export default {
  router,
  store
}
</script>
