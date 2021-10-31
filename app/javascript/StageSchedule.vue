<template>
  <div>
    <v-list>
      <v-list-item v-for="ticket in scheduleTickets" :key="ticket.id">
        <div class="customer_name">{{ ticket.customer_name }}</div>

        <count-ticket
          :id="ticket.id"
          :count="ticket.count"
          :tickets="tickets"
        ></count-ticket>
      </v-list-item>
    </v-list>

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
.customer_name {
  min-width: 8rem;
}
.v-list-item {
  justify-content: space-between;
}
</style>
