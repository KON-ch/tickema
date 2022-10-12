<template>
  <div class="unbooked-body">
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

    props: {
      keyword: {
        type: String,
        default: null
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

.candidate-ticket-card {
  margin: 24px;
}
</style>
