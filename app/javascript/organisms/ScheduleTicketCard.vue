<template>
  <v-card class="schedule-ticket-card">
    <v-row>
      <v-col cols="10" class="ticket-left">
        <template v-for="e in errors">
          <div :key="e" class="reserve-error">
            <font color="red">{{ e }}</font>
          </div>
        </template>

        <div class="select-schedule">
          {{schedule.staged_on}}{{schedule.staged_at}}
        </div>

        <v-row class="customer-name">
          <v-col class="last-name">
            <name-field v-model.trim="lastName" labelText="姓" />
          </v-col>
          <v-col class="first-name">
            <name-field v-model.trim="firstName" labelText="名" />
          </v-col>
        </v-row>

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
import NameField from '../Atoms/NameField.vue'

export default {
  components: {
    CountSelecter,
    NameField
  },

  data: function() {
    return {
      ticketCount: 0,
      firstName: "",
      lastName: "",
      errors: []
    }
  },

  props: {
    schedule: {
      type: Object,
      default: null
    }
  },

  methods: {
    reserveTicket: function() {
      this.errors = [];
      const customerName = this.lastName + this.firstName

      if (!this.ticketCount) { this.errors.push("枚数を選択して下さい") }
      if (customerName === "") { this.errors.push("名前を入力して下さい") }

      if (this.errors.length) { return }

      axios
        .post(`/reservations`, { reservation: { schedule_id: this.schedule.id, count: this.ticketCount }, customer: { name: customerName } })
        .then(res => { this.$store.commit("addTicket", res) })

      this.firstName = "";
      this.lastName = "";
      this.ticketCount = 0;
    }
  }
}
</script>

<style scoped>
  .schedule-ticket-card {
    border: solid gray;
    outline: 1px solid gray;
    outline-offset: -8px;
    padding: 32px 0;
  }

  .select-schedule {
    margin-top: 12px;
    text-align: center;
  }

  .customer-name {
    margin: 12px auto 0;
    width: 90%;
  }

  .first-name,.last-name {
    padding-bottom: 0;
  }

  .count-selecter {
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
