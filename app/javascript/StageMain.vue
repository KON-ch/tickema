<template>
  <div class="main-body">
    <v-app-bar
      absolute
      height="64px"
    >
      <v-toolbar-title><h1 class="stage-title">{{ title }}</h1></v-toolbar-title>

      <v-spacer></v-spacer>

      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <div class="nav-btn">
      <template v-for="(item, index) in tab_items">
        <v-btn
          :key="index"
          @click="tab = index"
          :class="activeButton(index)"
          depressed
          rounded
          small
        >
          <v-icon>mdi-{{item.icon}}</v-icon>{{ item.title }}
        </v-btn>
      </template>
    </div>

    <div class="page">
      <div v-show="tab === 0">
        <stage-top/>
      </div>

      <div v-show="tab === 1">
        <stage-ticket/>
      </div>

      <div v-show="tab === 2">
        <stage-candidate/>
      </div>
    </div>

    <user-menu v-model="drawer"/>
  </div>
</template>

<script>
  import axios from 'axios';
  import StageTop from './StageTop.vue'
  import StageTicket from './StageTicket.vue'
  import StageCandidate from './StageCandidate.vue'
  import UserMenu from './UserMenu.vue'
  import { csrfToken } from '@rails/ujs';
  import { mapState } from 'vuex';

  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

  export default {
    components: {
      StageTop,
      StageTicket,
      StageCandidate,
      UserMenu
    },

    data: function() {
      return {
        drawer: false,
        tab_items: [
          { title: "日付別", icon: "calendar-edit" },
          { title: "全て", icon: "account-multiple" },
          { title: "未予約", icon: "account-off-outline" },
        ],
        tab: 0,
      }
    },

    watch: {
      $route(to) {
        axios
          .get(`/stages/${to.params.id}`)
          .then((res) =>{ this.$store.commit("fetchStagesInfo", res) })
          .catch((e) => { console.error(e) })
      },
    },

    mounted() {
      axios
        .get(`/stages/${this.$route.params.id}`)
        .then((res) =>{ this.$store.commit("fetchStagesInfo", res) })
        .catch((e) => { console.error(e) })
    },

    computed: {
      ...mapState(["title"]),

      activeButton() {
        return function(index) {
          if (this.tab === index) { return 'active-button' }
        }
      }
    }
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

.nav-btn {
  margin: 96px 0 32px;
}

.nav-btn button {
  margin-left: 16px;
}

.page {
  height: 100vh;
  overflow-y: scroll;
}

.stage-title {
  font-size: 1.5rem;
  color: #3636eb;
}

.active-button {
  background-color: rgb(193 255 212) !important;
  color: #838383 !important;
}
</style>
