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
        >
          <v-list-item-title>
            <v-icon large class="title-icon">mdi-clipboard-list-outline</v-icon>公演一覧
          </v-list-item-title>
          <v-list-item v-for="stageList in stages" :key="stageList.id">
            <v-list-item-title>
              <router-link :to="{ path: `/stages/${stageList.id}` }" class="router-link">
                <v-icon class="content-icon">mdi-refresh</v-icon>
                {{ stageList.title }}
              </router-link>
            </v-list-item-title>
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

<style>
  header {
    margin-bottom: 2rem;
  }
  .v-list-item__title {
    margin-bottom: 1rem;
  }
  .title-icon {
    margin-right: 0.75rem;
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
