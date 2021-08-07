<template>
  <div>
    <h1>{{ stage.title }}</h1>
    <v-list>
      <v-list-group v-for="schedule in stage.schedules" :key="schedule.id" click="importCustomers">
        <template v-slot:activator>
          <v-list-item-title>
            {{ schedule.staging_date }}
            {{ schedule.start_time }}
          </v-list-item-title>
        </template>
        <v-list-item>
          <v-list-item-content>
            <stage-schedule-detail-page :customers="customers" :schedule_id="schedule.id"></stage-schedule-detail-page>
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
    StageScheduleDetailPage,
  },
  data: function() {
    return {
      stage: [],
      customers: [],
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
body {
  height: 100%;
}
h1{
  font-size: 2rem;
  margin-top: 2rem;
  text-align: center;
  color: gray;
}
.v-list-item {
  min-height: 5rem;
}
</style>
