<template>
  <div>
    <v-list v-if="customers.length">
      <v-list-item v-for="customer in customers" :key="customer.id">
        {{ customer.name }}
      </v-list-item>
    </v-list>
    <v-list v-else>
      頑張ってるのは知ってるよ
    </v-list>
    <customer-new-page :errors="errors" :customer="customer" @submit="createCustomer"></customer-new-page>
  </div>
</template>

<script>
import axios from 'axios';
import CustomerNewPage from './CustomerNewPage.vue';

export default {
  components: {
    CustomerNewPage
  },
  data: function() {
    return {
      customers: [],
      customer: {
        family_name: '',
        first_name: '',
      },
      errors: '',
    }
  },
  props: {
    schedule_id: ''
  },
  mounted() {
    axios
      .get(`/stage_schedules/${this.schedule_id}`)
      .then(response => (this.customers = response.data))
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
      this.customer = {};
      axios
        .get(`/stage_schedules/${this.schedule_id}`)
        .then(response => (this.customers = response.data))
    }
  }
}
</script>

<style scoped>
</style>
