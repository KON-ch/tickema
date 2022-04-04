<template>
  <v-card class="ticket">
    <trash-button :id="ticket.id" />

    <v-card-text>
      {{ticket.date}}{{ticket.time}}
    </v-card-text>
    <v-card-title class="name">
      {{ ticket.customer_name }}
    </v-card-title>

    <v-row>
      <v-col>
        <status-selecter :id="ticket.id" :status="ticket.status" />
      </v-col>
      <v-col>
        <ticket-counter :id="ticket.id" :count="ticket.count" />
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
import TrashButton from '../Atoms/TrashButton.vue'
import TicketCounter from '../Molecules/TicketCounter.vue';
import StatusSelecter from '../Atoms/StatusSelecter.vue'

export default {
  components: {
    TrashButton,
    TicketCounter,
    StatusSelecter,
  },

  props: {
    ticket: {
      type: Object,
      default: null
    }
  }
}
</script>

<style scoped>
  .name {
    text-align: center;
    display: block;
  }
</style>
