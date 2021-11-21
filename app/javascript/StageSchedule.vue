<template>
  <div>
    <v-row
      v-for="ticket in scheduleTickets"
      :key="ticket.id"
      class="customer-data"
    >
      <v-col cols="5" class="customer-name">{{ ticket.customer_name }}</v-col>
      <v-col cols="7" class="count-ticket">
        <count-ticket
          :id="ticket.id"
          :count="ticket.count"
          :tickets="tickets"
        ></count-ticket>
      </v-col>
    </v-row>

    <create-customer
      :id="id"
      :schedule_id="schedule_id"
      :tickets="tickets"
    ></create-customer>
  </div>
</template>

<script>
import CreateCustomer from './CreateCustomer.vue';
import CountTicket from './CountTicket.vue';

export default {
  components: {
    CreateCustomer,
    CountTicket,
  },

  data: function() {
    return {
      errors: '',
    }
  },

  props: {
    id: 0,
    schedule_id: 0,
    tickets: [],
  },

  computed: {
    scheduleTickets: function(){
      return this.tickets.filter(ticket => {
        return ticket.schedule_id == this.schedule_id
      })
    }
  },
}
</script>

<style scoped>
.customer-data {
  padding: 0;
  margin: 1rem 0 1.5rem;
}

.customer-name {
  font-weight: bold;
  font-size: 1.25rem;
  padding-top: 0.5rem;
  padding-right: 0;
}

.count-ticket {
  padding: 0;
}
</style>
