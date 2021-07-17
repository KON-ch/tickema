<template>
  <div>
    <h1>{{ stage.title }}</h1>
    <div>
      <ul v-for="schedule in stage.schedules" :key="schedule.id">
        <li>{{ schedule.staging_date }}{{ schedule.start_time }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      stage: []
    }
  },
  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  }
}
</script>

<style scoped>
</style>
