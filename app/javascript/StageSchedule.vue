<template>
  <div class="schedules">
    <create-customer
      :schedule_id="schedule_id"
    ></create-customer>

    <template v-for="ticket in tickets">
      <div class="ticket" :key="ticket.id">
        <ticket-card
          v-if="ticket.schedule_id === schedule_id"
          :ticket="ticket"
        />
      </div>
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

.ticket {
  margin-top: 32px;
}
</style>
