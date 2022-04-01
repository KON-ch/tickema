<template>
  <div>
    <template v-for="ticket in tickets">
      <v-row
        v-if="ticket.schedule_id == schedule_id"
        :key="ticket.id"
        class="customer-data"
      >
        <v-col cols="5" class="customer-name">{{ ticket.customer_name }}</v-col>
        <v-col cols="7" class="count-ticket">
          <count-ticket
            :id="ticket.id"
            :reservationId="ticket.reservation_id"
            :count="ticket.count"
          ></count-ticket>
        </v-col>
      </v-row>
    </template>

    <create-customer
      :schedule_id="schedule_id"
    ></create-customer>
  </div>
</template>

<script>
import CreateCustomer from './CreateCustomer.vue';
import CountTicket from './CountTicket.vue';
import { mapState } from 'vuex';

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
    schedule_id: {
      type: Number,
      default: 0,
    }
  },

  computed: mapState(["tickets"])
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
