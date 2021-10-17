<template>
  <div>
    <header-menu :stage="stage"></header-menu>

    <h2 class="content-title">
      <v-icon x-large class="content-icon">mdi-account-off-outline</v-icon>
      まだ予約していない人の一覧
    </h2>

    <v-text-field v-model="keyword" style="padding: 0 1rem;">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-simple-table>
      <template v-slot:default>
        <v-app>
          <tbody v-for="(customer, index) in search_customers" :key="index">
            <tr>
              <td class="customer_name">{{ customer.name }}</td>
            </tr>
            <tr>
              <td class="schedule_select">
                <v-select
                  v-model="schedule_id['customer_' + customer.id]"
                  :items="stage.schedules"
                  :item-text="item => item.staging_date + ' ' + item.start_time"
                  item-value="id"
                  filled
                  label="日程を選択"
                ></v-select>
              </td>
              <td>
                <v-btn v-on:click="createCustomer(customer.name, schedule_id['customer_' + customer.id])">
                  予約
                </v-btn>
              </td>
            </tr>
          </tbody>
        </v-app>
      </template>
    </v-simple-table>
  </div>
</template>

<script>
import axios from 'axios';
import HeaderMenu from './HeaderMenu.vue';

export default {
  components: {
    HeaderMenu
  },

  data: function() {
    return {
      stage: {},
      customers: {},
      keyword: "",
      schedule_id: {},
    }
  },

  watch: {
    $route(to) {
      axios
        .get(`/customers`, { params: { stage_id: this.$route.params.id } })
        .then(response => (this.customers = response.data))
      axios
        .get(`/stages/${this.$route.params.id}`)
        .then(response => (this.stage = response.data))
    }
  },

  mounted() {
    axios
      .get(`/customers`, { params: { stage_id: this.$route.params.id } } )
      .then(response => (this.customers = response.data))
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },

  computed: {
    search_customers: function(){
      if (this.keyword == "") return this.customers
      return this.customers.filter(customer => {
        return customer.name.includes(this.keyword)
      })
    },
  },

  methods: {
    createCustomer: function(name, schedule_id) {
      const split_name = name.split(" ")
      const customer = { family_name: split_name[0], first_name: split_name[1] }

      axios
        .post(`/customers`, { customer: customer, schedule: { id: schedule_id } })
        .then(this.customers = this.customers.filter(
          customer => customer.name != name
        ))
    },
  }
}
</script>

<style scoped>
  .customer_name {
    font-size: 1.25rem;
  }

  .schedule_select {
    width: 15rem;
    padding: 1rem 1rem 0 1rem;
  }

  td {
    border-bottom: thin solid rgba(0,0,0,.12);
  }

  tr {
    display: inline-block;
    margin: 0.5rem 1rem;
  }
</style>
