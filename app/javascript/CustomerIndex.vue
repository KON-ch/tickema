<template>
  <div>
    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <div v-for="customer in searchCustomers" :key="customer.id">
      {{ customer.name }}
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        customers: [],
        keyword: ""
      }
    },

    mounted() {
      axios
        .get(`/customers`)
        .then(response => (this.customers = response.data))
    },

    computed: {
      searchCustomers: function(){
        if (this.keyword == "") { return this.customers }

        return this.customers.filter(customer => {
          return customer.name.includes(this.keyword)
        })
      },
    }
  }

</script>
