<template>
  <div class="unbooked-body">
    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <template v-for="customer in searchCustomers">
      <candidate-ticket-card
        :key="customer.id"
        :customer="customer"
      />
    </template>
  </div>
</template>

<script>
  import { mapState } from 'vuex';
  import CandidateTicketCard from './organisms/CandidateTicketCard.vue';

  export default {
    components: { CandidateTicketCard },
    data: function() {
      return {
        keyword: "",
      }
    },

    computed: {
      ...mapState(["id", "schedules"]),
      ...mapState({ customers: "candidates"}),

      searchCustomers() {
        if (this.keyword == ""){ return this.customers }
        return this.$store.getters.searchCustomers(this.keyword)
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

.candidate-ticket-card {
  margin: 24px;
}
</style>
