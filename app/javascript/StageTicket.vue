<template>
  <div class="ticket-body">
    <search-form v-model="keyword" />

    <template v-for="ticket in searchTickets">
      <div class="ticket" :key="ticket.id">
        <ticket-card
          :ticket="ticket"
          style="padding-right: 1rem;"
        />
      </div>
    </template>

    <div style="text-align: center; margin: 1rem 0 3rem;">
      <v-btn elevation="2" @click="download">顧客一覧をダウンロードする</v-btn>
    </div>
  </div>
</template>

<script>
  import TicketCard from './organisms/TicketCard.vue'
  import SearchForm from './atoms/SearchForm.vue'
  import { mapState } from 'vuex';

  export default {
    components: {
      TicketCard,
      SearchForm
    },

    data: function() {
      return {
        keyword: "",
      }
    },

    computed: {
      ...mapState(["tickets"]),

      searchTickets() {
        if (this.keyword == ""){ return this.tickets }
        return this.$store.getters.searchTickets(this.keyword)
      }
    },

    methods: {
      // todo: only chrome
      download: function() {
        const today = new Date();
        let month = today.getMonth()
        if(month < 10) {
          month = "0" + month
        } else {
          month = month
        }

        let csv = this.tickets.map(ticket => {
          return [
            ticket.customer_name,
            ticket.date,
            ticket.time,
            `${ticket.count}枚`,
            "\n"
          ]
        })

        csv.unshift(["名前", "日付", "時間", "枚数", "\n"])

        const fileURL = URL.createObjectURL(new Blob(csv, {type:"text/csv"}));
        const fileLink = document.createElement("a");
        fileLink.href = fileURL;
        fileLink.setAttribute("download", "customers_" + month + today.getDate() + ".csv" );
        fileLink.click();
      }
    }
  }
</script>
<style scoped>
.ticket {
  margin: 32px 24px 0;
}

.ticket-body {
  margin-bottom: 10rem;
}

.customer-name {
  font-size: 1.5rem;
  font-weight: bold;
  text-align: center;
}

.date-time {
  margin: auto 0;
  padding-right: 0;
}

.status-btn {
  color: white;
  font-weight: bold;
}
</style>
