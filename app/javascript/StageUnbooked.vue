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

  export default {
    data: function() {
      return {
        keyword: "",
        scheduleIds: {},
        ticketsCount: {},
        counts: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      }
    },

    props: {
      id: 0,
      schedules: [],
      customers: [],
      tickets: [],
    },

    computed: {
      searchCustomers: function(){
        if (this.keyword == "") return this.customers

        return this.customers.filter(customer => {
          return customer.name.includes(this.keyword)
        })
      },
    },

    methods: {
      createTicket: function(count, customer_id, schedule_id) {
        const index = this.customers.findIndex(customer => customer.id == customer_id)

        if (index == -1) {
          const errorMessage = "登録できませんでした"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .post(`/tickets`, { ticket: { count: count, stage_id: this.id, customer_id: customer_id, schedule_id: schedule_id } })
          .then(response => { this.tickets.push(response.data) })

        this.customers.splice(index, 1)
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
