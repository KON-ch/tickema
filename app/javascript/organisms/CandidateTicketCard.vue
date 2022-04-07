<template>
  <v-card class="candidate-ticket-card">
    <v-row>
      <v-col cols="10" class="ticket-left">
        <template v-for="e in errors">
          <div :key="e" class="reserve-error">
            <font color="red">{{ e }}</font>
          </div>
        </template>

        <div class="name">
          {{ customer.name }}
        </div>

        <div class="schedule-selecter">
          <schedule-selecter v-model="scheduleId" />
        </div>

        <div class="count-selecter">
          <count-selecter v-model="ticketCount" />
        </div>
      </v-col>
      <v-col cols="2" class="ticket-right">
        <v-btn
          class="reserve-button"
          absolute
          color="teal accent-1"
          rounded
          small
          @click="reserveTicket"
        >予約</v-btn>
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
import axios from 'axios';
import CountSelecter from '../Atoms/CountSelecter.vue';
import ScheduleSelecter from '../Atoms/ScheduleSelecter.vue';

export default {
  components: {
    CountSelecter,
    ScheduleSelecter
  },

  data: function() {
    return {
      ticketCount: 0,
      scheduleId: 0,
      errors: []
    }
  },

  props: {
    customer: {
      type: Object,
      default: null
    }
  },

  methods: {
    reserveTicket: function() {
      this.errors = [];

      if (!this.ticketCount) { this.errors.push("枚数を選択して下さい") }
      if (!this.scheduleId) { this.errors.push("日時をを選択して下さい") }

      if (this.errors.length) { return }

      axios
        .post(`/reservations`, { reservation: { schedule_id: this.scheduleId, count: this.ticketCount }, customer: { name: this.customer.name } })
        .then(res => { this.$store.commit("addTicket", res) })

      this.$store.commit("deleteCustomer", this.customer.id)
    }
  }
}
</script>

<style scoped>
  .candidate-ticket-card {
    border: solid gray;
    outline: 1px solid gray;
    outline-offset: -8px;
    padding: 32px 0;
  }

  .name {
    text-align: center;
    margin-top: 12px;
    font-size: 24px;
  }

  .schedule-selecter,.count-selecter {
    margin: 16px auto;
    height: 32px;
    width: 180px;
  }

  .ticket-left {
    border-right: dotted;
    border-color: gray;
    border-width: 1px;
  }

  .reserve-button {
    left: 75%;
    top: 75%;
  }

  .reserve-error {
    text-align: center;
  }
</style>
