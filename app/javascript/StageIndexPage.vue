<template>
  <div id="app">
    <div>Index</div>
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <th>title</th>
        </tr>
        <tr v-for="s in stages" :key="s.id">
          <td><router-link :to="{ name: 'StageDetailPage', params: { id: s.id } }">{{ s.id }}</router-link></td>
          <td>{{ s.title }}</td>
        </tr>
      </tbody>
    </table>
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
    axios
      .get(`/stages`)
      .then(response => (this.stages = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
