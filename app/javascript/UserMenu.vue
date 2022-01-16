<template>
  <v-navigation-drawer
    :value="value"
    absolute
    temporary
    @input="$emit('input', $event)"
  >
    <v-list
      nav
      dense
      hegiht="100vh"
    >
      <v-list-item-group>
        <v-list-item-title class="link-title">
          公演ページ
        </v-list-item-title>
        <v-list-item v-for="stage in stages" :key="stage.id">
          <router-link
            :to="{ name: 'StageMain', params: { id: stage.id } }"
            class="link-content"
          >
            <v-icon>mdi-hand-pointing-right</v-icon>
            <span class="link-content_title">{{ stage.title }}</span>
          </router-link>
        </v-list-item>
      </v-list-item-group>
      <v-list-item-group>
        <v-list-item-title class="link-title">
          設定
        </v-list-item-title>
        <v-list-item>
          <router-link
            :to="{ name: 'CustomerIndex' }"
            class="link-content"
          >
            <v-icon>mdi-account-edit</v-icon>
            <span class="link-content_title">顧客情報</span>
          </router-link>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    props: {
      value: {
        type: Boolean,
        default: false
      }
    },

    computed: mapState(["stages"])
  }
</script>

<style scoped>
.link-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin: 1rem;
  color: darkblue;
}

.link-content {
  text-decoration: none;
}

.link-content_title {
  font-weight: bold;
  margin-left: 0.5rem;
}
</style>
