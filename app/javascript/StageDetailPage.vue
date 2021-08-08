<template>
  <div>
    <h1>{{ stage.title }}</h1>
    <customer-search :customers="stage.customers"></customer-search>
    <div class="total_count">合計 {{ stage.customers.length }} 人</div>
    <v-list>
      <v-list-group v-for="schedule in stage.schedules" :key="schedule.id" click="importCustomers">
        <template v-slot:activator>
          <v-list-item-title>
            {{ schedule.staging_date }}
            {{ schedule.start_time }}
            <span>{{ scheduleCustomers(schedule.staging_date) }}人</span>
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
import CustomerSearch from './CustomerSearch.vue'
import StageScheduleDetailPage from './StageScheduleDetailPage.vue';

export default {
  components: {
    StageScheduleDetailPage,
    CustomerSearch,
  },
  data: function() {
    return {
      stage: {
        customers: [],
      },
      customers: [],
    }
  },
  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },
  computed: {
    scheduleCustomers: function(){
      return function(date) {
        let customers = this.stage.customers
        return customers.filter(customer => {
          return customer.schedule === date
        }).length
      }
    }
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
span {
  margin-left: 1.5rem;
  color: gray;
}
.total_count {
  text-align: right;
  margin-right: 1.5rem;
  color: gray;
}
</style>
