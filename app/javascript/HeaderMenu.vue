<template>
  <div>
    <v-app-bar
      color="deep-purple accent-4"
      height="64px"
      prominent
    >
      <v-toolbar-title>{{ stage.title }}</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
    >
      <v-list
        nav
        dense
      >
        <v-list-item-group
          v-model="group"
          active-class="deep-purple--text text--accent-4"
          v-for="stageList in stages" :key="stageList.id"
        >
          <v-list-item-title>{{ stageList.title }}</v-list-item-title>
          <v-list-item>
            <router-link :to="{ path: `/stages/${stageList.id}` }" class="router-link">
              <v-icon class="content-icon">mdi-clipboard-list-outline</v-icon>公演詳細
            </router-link>
          </v-list-item>
          <v-list-item>
            <router-link :to="{ path: `/customers/${stageList.id}` }" class="router-link">
              <v-icon class="content-icon">mdi-account-multiple</v-icon>顧客一覧
            </router-link>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        drawer: false,
        group: null,
        stages: [],
      }
    },

    props: {
      stage: {}
    },

    watch: {
      group () {
        this.drawer = false
      }
    },

    mounted() {
      axios.get(`/mypage`).then(response => (this.stages = response.data))
    }
  }
</script>

<style scoped>
  header {
    margin-bottom: 2rem;
  }
  .v-list-item__title {
    margin: 1rem 0;
    font-weight: bold;
  }
  .content-icon {
    margin-left: 1rem;
    margin-right: 0.5rem;
  }
  .router-link{
    text-decoration: none;
    color: gray;
  }
  .router-link-active {
    color: lightgray;
  }

</style>
