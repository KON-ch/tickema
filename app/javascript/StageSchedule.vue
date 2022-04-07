<template>
  <div class="schedules">
    <template v-for="ticket in tickets">
      <div class="ticket" :key="ticket.id">
        <ticket-card
          v-if="ticket.schedule_id === schedule.id"
          :ticket="ticket"
        />
      </div>
    </template>

    <schedule-ticket-card :schedule="schedule" />
  </div>
</template>

<script>
import { mapState } from 'vuex';
import CreateCustomer from './CreateCustomer.vue';
import TicketCard from './organisms/TicketCard.vue';
import ScheduleTicketCard from './organisms/ScheduleTicketCard.vue'

export default {
  components: {
    CreateCustomer,
    TicketCard,
    ScheduleTicketCard
  },

  data: function() {
    return {
      errors: '',
    }
  },

  props: {
    schedule: {
      type: Object,
      default: null,
    }
  },

  computed: mapState(["tickets"])
}
</script>

<style scoped>
.schedules > .v-form {
  margin-top: 0 !important;
}

.ticket {
  margin-top: 32px;
}

.schedule-ticket-card {
  margin-top: 32px;
}
</style>
