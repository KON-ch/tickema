<template>
  <div>
    <v-text-field v-model="keyword" style="padding: 1rem 1rem 0 1rem;">
      <template v-slot:label>検索</template>
    </v-text-field>

    <div>
      <v-simple-table>
        <template v-slot:default>
          <div>
            <tbody v-for="customer in searchCustomers" :key="customer.id">
              <tr>
                <td class="customer_name">{{ customer.name }}</td>
              </tr>
              <tr>
                <td class="schedule_select">
                  <v-select
                    v-model="scheduleIds[`schedule_${customer.id}`]"
                    :items="schedules"
                    :item-text="schedule => schedule.staged_on + ' ' + schedule.staged_at"
                    item-value="id"
                    filled
                    label="日程を選択"
                  ></v-select>
                  <v-select
                    v-model="ticketsCount[`count_${customer.id}`]"
                    :items="counts"
                    filled
                    label="枚数を選択"
                  ></v-select>
                </td>
                <td>
                  <v-btn
                    @click="createTicket(ticketsCount[`count_${customer.id}`], customer.id, scheduleIds[`schedule_${customer.id}`])"
                  >予約</v-btn>
                </td>
              </tr>
            </tbody>
          </div>
        </template>
      </v-simple-table>
    </div>
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
        const index = this.customers.map((customer, index) => { if(customer.id == customer_id){ return index } }).filter(Boolean)

        axios
          .post(`/tickets`, { ticket: { count: count, stage_id: this.id, customer_id: customer_id, schedule_id: schedule_id } })
          .then(response => {
            this.tickets.push(response.data)
          })

        this.customers.splice(index[0], 1)
      },
    }
  }
</script>
