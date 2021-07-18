<template>
  <div>
    <h1>{{ stage.title }}</h1>
    <v-list>
      <v-list-group v-for="schedule in stage.schedules" :key="schedule.id">
        <template v-slot:activator>
          <v-list-item-title>
            {{ schedule.staging_date }}{{ schedule.start_time }}
          </v-list-item-title>
        </template>
        <v-list-item>
          <v-list-item-content>
              hello
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
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
