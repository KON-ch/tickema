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
export default {
  data: function() {
    return {
      keyword: '',
    }
  },
  props: {
    customers: [],
  },
  computed: {
    search_customers: function(){
      if (this.keyword === "") return {}
      return this.customers.filter(customer => {
        return customer.name.includes(this.keyword)
      })
    }
  }
}
</script>

<style scoped>
div {
  padding: 0 1rem;
}
</style>
