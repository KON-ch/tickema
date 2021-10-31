<template>
  <div id="app">
    <div v-for="stage in stages" :key="stage.id">
      <router-link :to="{ name: 'StageDetailPage', params: { id: stage.id } }">
        {{ stage.title }}
      </router-link>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      stages: []
    }
  },
  mounted() {
    axios.get(`/mypage`).then(response => (this.stages = response.data))
  },
}
</script>

<style scoped>
</style>
