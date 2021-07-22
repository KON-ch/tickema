<template>
  <v-list v-if="customers.length">
    <v-list-item v-for="customer in customers" :key="customer.id">
      {{ customer.name }}
    </v-list-item>
  </v-list>
  <v-list v-else>
    頑張ってるのは知ってるよ
  </v-list>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      customers: [],
    }
  },
  props: ['schedule_id'],
  mounted() {
    axios
      .get(`/stage_schedules/${this.schedule_id}`)
      .then(response => (this.customers = response.data))
  }
}
</script>

<style scoped>
</style>
