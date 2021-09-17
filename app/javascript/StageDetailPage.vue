<template>
  <v-card height="100vh">
    <header-menu :stage="stage"></header-menu>

    <customer-search :customers="stage.customers"></customer-search>

    <div class="total_count">合計 {{ customersCount }} 人</div>
    <v-list>
      <v-list-group v-for="schedule in stage.schedules" :key="schedule.id">
        <template v-slot:activator>
          <v-list-item-title>
            <span class="schedule_list">
              {{ schedule.staging_date }}
              {{ schedule.start_time }}
            </span>
            <span class="customer_count">{{ scheduleCustomersCount(schedule.id) }}人</span>
          </v-list-item-title>
        </template>
        <v-list-item>
          <v-list-item-content>
            <stage-schedule-detail-page
              :customers="stage.customers"
              :schedule_id="schedule.id"
              :date="schedule.staging_date"
              :stage_id="stage.id"
            ></stage-schedule-detail-page>
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
  </v-card>
</template>

<script>
import axios from 'axios';
import CustomerSearch from './CustomerSearch.vue'
import HeaderMenu from './HeaderMenu.vue'
import StageScheduleDetailPage from './StageScheduleDetailPage.vue';

export default {
  components: {
    StageScheduleDetailPage,
    CustomerSearch,
    HeaderMenu
  },
  data: function() {
    return {
      stage: {
        customers: [],
      },
    }
  },

  watch: {
    $route(to) {
      axios
      .get(`/stages/${to.params.id}`)
      .then(response => (this.stage = response.data))
    }
  },

  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },

  computed: {
    customersCount: function() {
      let count = 0
      this.stage.customers.forEach(customer => {
        count += customer.count
      })
      return count
    },
    scheduleCustomersCount: function(){
      return function(schedule_id) {
        let count = 0
        this.stage.customers.forEach(customer => {
          if (customer.schedule_id === schedule_id) count += customer.count
        })
        return count
      }
    }
  },
}
</script>

<style scoped>
body {
  height: 100%;
}
.v-list-item {
  min-height: 5rem;
}
.customer_count {
  margin-left: 1.5rem;
  color: gray;
}
.total_count {
  text-align: right;
  margin-right: 1.5rem;
  color: gray;
}
.schedule_list {
  min-width: 9rem;
  display: inline-block;
  text-align: right;
}
</style>
