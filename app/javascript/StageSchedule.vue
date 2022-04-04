<template>
  <div class="schedules">
    <create-customer
      :schedule_id="schedule_id"
    ></create-customer>

    <template v-for="ticket in tickets">
      <ticket-card
        v-if="ticket.schedule_id === schedule_id"
        :key="ticket.id"
        :ticket="ticket"
      />
    </template>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import CreateCustomer from './CreateCustomer.vue';
import TicketCard from './organisms/TicketCard.vue';

export default {
  components: {
    CreateCustomer,
    TicketCard
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
.schedules > .v-form {
  margin-top: 0 !important;
}

.schedules {
  margin-bottom: 128px;
}

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
