<template>
  <v-card class="main-body">
    <v-app-bar
      absolute
      height="64px"
    >
      <v-toolbar-title><h1 class="stage-title">{{ title }}</h1></v-toolbar-title>

      <v-spacer></v-spacer>

      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

      <template v-slot:extension>
        <v-tabs
          v-model="tab"
          fixed-tabs
        >
          <v-tab v-for="(item, index) in tab_items" :key="index">
            <v-icon>mdi-{{item.icon}}</v-icon>{{ item.title }}
          </v-tab>
        </v-tabs>
      </template>
    </v-app-bar>

    <v-card class="tab-items">
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <stage-top
            :id="id"
            :schedules="schedules"
            :tickets="tickets"
          ></stage-top>
        </v-tab-item>

        <v-tab-item>
          <stage-ticket
            :tickets="tickets"
          ></stage-ticket>
        </v-tab-item>

        <v-tab-item>
          <stage-unbooked
            :id="id"
            :schedules="schedules"
            :customers="unbookedCustomers"
            :tickets="tickets"
          ></stage-unbooked>
        </v-tab-item>
      </v-tabs-items>
    </v-card>

    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
    >
      <v-list
        nav
        dense
        hegiht="100vh"
      >
        <v-list-item-group
          v-model="group"
          v-for="stage in stages" :key="stage.id"
        >
          <v-list-item>
            <router-link :to="{ name: 'StageMain', params: { id: stage.id } }">
              {{ stage.title }}
            </router-link>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </v-card>
</template>

<script>
  import axios from 'axios';
  import StageTop from './StageTop.vue'
  import StageTicket from './StageTicket.vue'
  import StageUnbooked from './StageUnbooked.vue'
  import { csrfToken } from '@rails/ujs';

  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()


  export default {
    components: {
      StageTop,
      StageTicket,
      StageUnbooked
    },

    data: function() {
      return {
        id: 0,
        title: "",
        stages: [],
        schedules: [],
        tickets: [],
        unbookedCustomers: [],
        drawer: false,
        group: null,
        tab_items: [
          { title: "TOP", icon: "calendar-edit" },
          { title: "予約済み", icon: "account-multiple" },
          { title: "未予約", icon: "account-off-outline" },
        ],
        tab: null,
      }
    },

    watch: {
      $route(to) {
        axios
          .get(`/stages/${to.params.id}`)
          .then(response => (
            this.id = response.data.id,
            this.title = response.data.title,
            this.stages = response.data.stages,
            this.schedules = response.data.schedules,
            this.tickets = response.data.tickets,
            this.unbookedCustomers = response.data.unbooked_customers
          ))
      },

      group () {
        this.drawer = false
      }
    },

    mounted() {
      axios
        .get(`/stages/${this.$route.params.id}`)
        .then(response => (
          this.id = response.data.id,
          this.title = response.data.title,
          this.stages = response.data.stages,
          this.schedules = response.data.schedules,
          this.tickets = response.data.tickets,
          this.unbookedCustomers = response.data.unbooked_customers
        ))
    },
  }
</script>
<style scoped>
.main-body {
  position:fixed;
  top: 0;
  right: 0;
  left: 0;
}

.main-body::-webkit-scrollbar {
  display: none;
}

.tab-items {
  height: 100vh;
  overflow-y: scroll;
  padding-top: 7rem;
}

.stage-title {
  font-size: 1.5rem;
  color: #3636eb;
}
</style>
