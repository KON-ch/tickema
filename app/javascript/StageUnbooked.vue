<template>
  <div class="unbooked-body">
    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-simple-table>
      <template v-slot:default>
        <div v-for="customer in searchCustomers" :key="customer.id" class="unbooked-user">
          <v-row>
            <v-col class="customer-name">{{ customer.name }}</v-col>
          </v-row>
          <template v-if="errors[`customer_${customer.id}`]">
            <v-row v-for="e in errors[`customer_${customer.id}`]" :key="e" style="margin-bottom: 0.5rem">
              <div style="margin-left: 2rem"><font color="red">{{ e }}</font></div>
            </v-row>
          </template>
          <v-row class="select-form">
            <v-col cols="8" class="select-schedule">
              <v-select
                v-model="scheduleIds[`schedule_${customer.id}`]"
                :items="schedules"
                :item-text="schedule => schedule.staged_on + ' ' + schedule.staged_at"
                item-value="id"
                filled
                label="公演日時"
              ></v-select>
            </v-col>
            <v-col cols="4" class="select-count">
              <v-select
                v-model="ticketsCount[`count_${customer.id}`]"
                :items="counts"
                filled
                label="枚数"
              ></v-select>
            </v-col>
          </v-row>
          <v-row style="margin: 0;">
            <v-col class="reserved-btn">
              <v-btn
                block
                color="blue"
                class="reserved-btn_content"
                @click="createTicket(ticketsCount[`count_${customer.id}`], customer.id, scheduleIds[`schedule_${customer.id}`])"
              >予約</v-btn>
            </v-col>
          </v-row>
        </div>
      </template>
    </v-simple-table>
  </div>
</template>

<script>
  import axios from 'axios';
import { mapState } from 'vuex';

  export default {
    data: function() {
      return {
        keyword: "",
        scheduleIds: {},
        ticketsCount: {},
        counts: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        errors: {}
      }
    },

    computed: {
      ...mapState(["id", "schedules"]),
      ...mapState({ customers: "unbookedCustomers"}),

      searchCustomers() {
        if (this.keyword == ""){ return this.customers }
        return this.$store.getters.searchCustomers(this.keyword)
      },
    },

    methods: {
      createTicket: function(count, customer_id, schedule_id) {
        const errors = []

        if (!count) { errors.push("枚数を選択して下さい") }

        if (!schedule_id) { errors.push("日時をを選択して下さい") }

        const index = this.customers.findIndex(customer => customer.id == customer_id)

        if (index == -1) { errors.push("登録できませんでした") }

        if (errors.length) {
          return this.$set(this.errors, `customer_${customer_id}`, errors)
        }

        axios
          .post(`/tickets`, { ticket: { count: count, stage_id: this.id, customer_id: customer_id, schedule_id: schedule_id } })
          .then(res => { this.$store.commit("addTicket", res) })

        this.$store.commit("deleteCustomer", index)
      },
    }
  }
</script>
<style scoped>
.search-form {
  padding: 2rem 2rem 1rem;
}

.unbooked-body {
  margin-bottom: 10rem;
}

.unbooked-user {
  padding: 0 1rem;
}
.customer-name{
  font-size: 1.5rem;
  font-weight: bold;
  padding-bottom: 1rem;
  padding-left: 1.5rem;
}

.select-form {
  margin: 0;
  padding-top: 0;
  padding-bottom: 0;
}

.select-schedule,.select-count {
  padding-bottom: 0;
}

.reserved-btn {
  padding: 0 1rem;
  margin-bottom: 4rem;
  text-align: center;
}

.reserved-btn_content {
  color: white;
  font-weight: bold;
}
</style>
