<template>
  <div class="ticket-body">
    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <div v-for="ticket in searchTickets" :key="ticket.id" style="padding-right: 1rem;">
      <v-row>
        <v-col cols="6" class="customer-name">
          {{ ticket.customer_name }}
        </v-col>
        <v-col cols="3" class="date-time">
          {{ ticket.date }}
        </v-col>
        <v-col cols="3" class="date-time">
          {{ ticket.time }}
        </v-col>
      </v-row>
      <v-row style="margin: 0;">
        <v-col cols="6" style="padding-right: 0">
          <count-ticket
            :id="ticket.id"
            :count="ticket.count"
          ></count-ticket>
        </v-col>
        <v-col cols="3" style="padding-left: 0;">
          <!-- Jestでclickイベントをテストする為に@click.nativeとしている -->
          <v-btn
            :color="setStatusColor(ticket.status)"
            class="status-btn"
            @click.native="updateStatus(ticket.id, statusNum[ticket.status] + 1)"
          >{{ statusLocales[ticket.status] }}
          </v-btn>
        </v-col>
        <v-col cols="3" style="padding-left: 1rem;">
          <v-select
            v-model="submitStatus[`status_${ticket.id}`]"
            :items="selectStatus"
            :item-text="item => item.text"
            :item-value="item => item.num"
            filled
            dense
            style="width: 4rem"
            rounded
            @input="updateStatus(ticket.id, submitStatus[`status_${ticket.id}`])"
          ></v-select>
        </v-col>
      </v-row>
    </div>

    <div style="text-align: center; margin: 1rem 0 3rem;">
      <v-btn elevation="2" @click="download">顧客一覧をダウンロードする</v-btn>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import CountTicket from './CountTicket.vue';
  import { mapState } from 'vuex';

  export default {
    components: {
      CountTicket,
    },

    data: function() {
      return {
        keyword: "",
        submitStatus: {},
        selectStatus: [
          { num: 0, text: "予約済み" },
          { num: 1, text: "申請済み" },
          { num: 2, text: "連絡済み" },
          { num: 3, text: "お礼済み" },
        ],
        statusLocales: {
          reserved: "予約済み",
          applied: "申請済み",
          notified: "連絡済み",
          finished: "お礼済み",
        },
        statusNum: {
          reserved: 0,
          applied: 1,
          notified: 2,
          finished: 3,
        },
      }
    },

    computed: {
      ...mapState(["tickets"]),

      searchTickets() {
        if (this.keyword == ""){ return this.tickets }
        return this.$store.getters.searchTickets(this.keyword)
      },

      setStatusColor: function() {
        return function(status) {
          switch(status) {
            case "reserved":
              return "indigo"
            case "applied":
              return "amber"
            case "notified":
              return "red";
            case "finished":
              return "teal"
          }
        }
      },
    },

    methods: {
      updateStatus: function(id, status){
        if (status > 3) { return }

        axios
          .patch(`/reservations/${id}/status`, { reservation: { status: status }})
          .then(res => {
            this.$store.commit("updateStatus", { id: id, status: res.data })
            this.$set(this.submitStatus, `status_${id}`, this.statusNum[res.data])
          })
      },

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
.ticket-body {
  margin-bottom: 10rem;
}

.search-form {
  padding: 2rem 2rem 1rem;
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
