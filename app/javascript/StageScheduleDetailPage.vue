<template>
  <div>
    <v-list v-if="customers.length">
      <v-list-item v-for="customer in scheduleCustomers" :key="customer.id">
        <div class="customer_name">{{ customer.name }}</div>
        <div v-if="customer.count > 1">
          <v-btn v-on:click="customerCountDown(customer.id, customer.count)" icon>
            <v-icon>mdi-minus</v-icon>
          </v-btn>
        </div>
        <div v-else><v-icon class="minus_btn">mdi-minus</v-icon></div>
        <div>
          <v-btn v-on:click="customerCountUp(customer.id, customer.count)" icon>
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </div>
        <div>
          {{ customer.count }}枚
        </div>
        <div class="trash_btn">
          <v-btn v-on:click="deleteTarget = customer.id; showModal = true" icon>
            <v-icon>mdi-trash-can-outline</v-icon>
          </v-btn>
        </div>
      </v-list-item>
    </v-list>
    <customer-new-page :errors="errors" :customer="customer" @submit="createCustomer"></customer-new-page>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteCustomer(deleteTarget); showModal = false;">
        <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
import axios from 'axios';
import CustomerNewPage from './CustomerNewPage.vue';
import { csrfToken } from '@rails/ujs';
import Modal from 'Modal.vue'

axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  components: {
    CustomerNewPage,
    Modal
  },
  data: function() {
    return {
      customer: {
        family_name: '',
        first_name: '',
      },
      showModal: false,
      deleteTarget: -1,
      errors: '',
    }
  },
  props: {
    customers: [],
    schedule_id: '',
    date: '',
    stage_id: '',
  },
  computed: {
    scheduleCustomers: function(){
      return this.customers.filter(customer => {
        return customer.schedule_id === this.schedule_id
      })
    }
  },
  methods: {
    createCustomer: function() {
      axios
        .post(`/customers`, { customer: this.customer, schedule: { id: this.schedule_id } })
        .then(response => {
          this.customers.push({ id: response.data.id, name: response.data.name, schedule: this.date, schedule_id: this.schedule_id, count: 1 });
          this.$router.push({ path: `/stages/${this.stage_id}` });
          this.errors = '';
        })
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
        .then(this.customers.splice(this.customers.map(function(customer, index) {
            if (customer.id === id) return index
          }).filter(Boolean)[0], 1
        ))
    },
    customerCountUp: function(id, count) {
      axios
        .put(`/customers/${id}/count`, { customer: { schedule_id: this.schedule_id, count: count + 1 } })
        .then(this.customers.map(customer => {
          if (customer.id === id) customer.count = count + 1
        }))
    },
    customerCountDown: function(id, count) {
      axios
        .put(`/customers/${id}/count`, { customer: { schedule_id: this.schedule_id, count: count - 1 } })
        .then(this.customers.map(customer => {
          if (customer.id === id) customer.count = count - 1
        }))
    }
  }
}
</script>

<style scoped>
.customer_name {
  min-width: 8rem;
}
.v-list-item {
  justify-content: space-between;
}
.minus_btn {
  min-width: 36px;
  color: lightgray;
}
.trash_btn {
  padding: 0 1rem;
}
</style>
