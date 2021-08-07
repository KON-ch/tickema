<template>
  <div id="app">
    <div><router-link :to="{ name: 'StageDetailPage', params: { id: stage.id } }">{{ stage.title }}</router-link></div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      stage: {
        id: '',
        title: '',
      }
    }
  },
  mounted() {
    axios.get(`/mypage`).then(response => (this.stage = response.data))
  },
}
</script>

<style scoped>
div{
  text-align: center;
  margin-top: 3vh;
}
a{
  text-decoration: none;
  color: blue;
}
</style>
