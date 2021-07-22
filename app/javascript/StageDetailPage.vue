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
            <stage-schedule-detail-page :customers="customers" :schedule_id="schedule.id"></stage-schedule-detail-page>
            <customer-new-page :schedule_id="schedule.id" :customer="customer" @submit="createCustomer" :errors="errors" ></customer-new-page>
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
  </div>
</template>

<script>
import axios from 'axios';
import StageScheduleDetailPage from './StageScheduleDetailPage.vue';
import CustomerNewPage from './CustomerNewPage.vue';

export default {
  components: {
    StageScheduleDetailPage,
    CustomerNewPage
  },
  data: function() {
    return {
      stage: [],
      customers: [],
      customer: {
        family_name: '',
        first_name: '',
      },
      errors: ''
    }
  },
  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },
  methods: {
    createCustomer: function() {
      axios
        .post(`/customers`, { customer: this.customer, schedule_id: this.schedule_id })
        .then(response => { response.data })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
</style>
