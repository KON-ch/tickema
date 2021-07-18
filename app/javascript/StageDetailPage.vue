<template>
  <div>
    <h1>{{ stage.title }}</h1>
    <v-list>
      <v-list-group v-for="schedule in stage.schedules" :key="schedule.id" click="importCustomers">
        <template v-slot:activator>
          <v-list-item-title>
            {{ schedule.staging_date }}{{ schedule.start_time }}
          </v-list-item-title>
        </template>
        <v-list-item>
          <v-list-item-content>
            <stage-schedule-detail-page :customers="customers" :id="schedule.id" ></stage-schedule-detail-page>
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
  </div>
</template>

<script>
import axios from 'axios';
import StageScheduleDetailPage from './StageScheduleDetailPage.vue';

export default {
  components: {
    StageScheduleDetailPage
  },
  data: function() {
    return {
      stage: [],
      customers: []
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
