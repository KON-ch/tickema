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
        <tbody v-for="(customer, index) in search_customers" :key="index">
          <tr>
            <td>{{ customer.name }}</td>
            <td></td>
            <td></td>
          </tr>
        </tbody>
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
    }
  },

  watch: {
    $route(to) {
      axios
        .get(`/customers`)
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
    }
  }
}
</script>

<style scoped>
  td {
    border-bottom: thin solid rgba(0,0,0,.12);
  }
</style>
