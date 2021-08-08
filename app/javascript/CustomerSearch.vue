<template>
  <div>
    <v-text-field v-model="keyword">
      <template v-slot:label>検索</template>
    </v-text-field>
    <div v-for="customer in search_customers" :key="customer.id">
      {{ customer.name }}は{{ customer.schedule }}です
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data: function() {
    return {
      keyword: '',
      customers: [],
    }
  },
  computed: {
    search_customers: function(){
      if (this.keyword === "") return {}
      return this.customers.filter(customer => {
        return customer.name.includes(this.keyword)
      })
    }
  },
  mounted() {
    axios
      .get(`/customers/search/${this.$route.params.id}`)
      .then(response => { this.customers = response.data })
  }
}
</script>

<style scoped>
div {
  padding: 0 1rem;
}
</style>
