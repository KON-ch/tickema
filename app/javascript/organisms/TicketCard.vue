<template>
  <v-card class="ticket-card">
    <v-row>
      <v-col cols="2" class="trash-button">
        <trash-button :id="ticket.id" />
      </v-col>
      <v-col cols="9" class="date">
        {{ticket.date}}{{ticket.time}}
      </v-col>
    </v-row>

    <div class="name">
      {{ ticket.customer_name }}
    </div>

    <v-row class="infomation">
      <v-col cols="6" class="status">
        <status-selecter :id="ticket.id" :status="ticket.status" />
      </v-col>
      <v-col cols="5" class="count">
        <ticket-counter :id="ticket.id" :count="ticket.count" />
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
import TrashButton from '../atoms/TrashButton.vue';
import TicketCounter from '../molecules/TicketCounter.vue';
import StatusSelecter from '../atoms/StatusSelecter.vue';

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
  .ticket-card {
    border: solid gray;
    outline: 1px solid gray;
    outline-offset: -8px;
  }

  .trash-button {
    margin-top: 8px;
    margin-left: 8px;
  }

  .date {
    margin: 32px 0 0;
  }

  .name {
    text-align: center;
    margin-top: 24px;
    font-size: 24px;
  }

  .infomation {
    margin-top: 8px;
  }

  .status {
    margin-left: 16px;
    padding-right: 0;
  }

  .count {
    padding-left: 0;
    margin-top: 8px;
  }

  .col {
    max-height: 96px;
  }
</style>
