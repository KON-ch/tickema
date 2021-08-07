<template>
  <div>
    <v-list v-if="customers.length">
      <v-list-item v-for="customer in customers" :key="customer.id">
        <div class="customer_name">{{ customer.name }}</div>
        <v-btn v-on:click="deleteCustomer(customer.id)" icon><v-icon>mdi-trash-can-outline</v-icon></v-btn>
      </v-list-item>
    </v-list>
    <customer-new-page :errors="errors" :customer="customer" @submit="createCustomer"></customer-new-page>
  </div>
</template>

<script>
import axios from 'axios';
import CustomerNewPage from './CustomerNewPage.vue';
import { csrfToken } from '@rails/ujs';

axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

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
    schedule_id: '',
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
        .then(response => { this.imoprtCustomer(); })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
      this.customer = {};
    },
    deleteCustomer: function(id) {
      axios
        .delete(`/customers/${id}`)
        .then(response => { this.imoprtCustomer(); })
    },
    imoprtCustomer: function() {
      axios
        .get(`/stage_schedules/${this.schedule_id}`)
        .then(response => (this.customers = response.data));
    }
  }
}
</script>

<style scoped>
.customer_name {
  min-width: 15rem;
}
.v-list-item {
  justify-content: space-between;
}
</style>
