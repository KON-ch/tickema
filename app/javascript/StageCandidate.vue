<template>
  <div class="unbooked-body">
    <search-form v-model="keyword" />

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
  import SearchForm from './atoms/SearchForm.vue';
  import CandidateTicketCard from './organisms/CandidateTicketCard.vue';

  export default {
    components: {
      CandidateTicketCard,
      SearchForm
    },

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

.unbooked-body {
  margin-bottom: 10rem;
}

.candidate-ticket-card {
  margin: 24px;
}
</style>
