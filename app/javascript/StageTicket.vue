<template>
  <div>
    <v-text-field v-model="keyword" style="padding: 1rem 1rem 0 1rem;">
      <template v-slot:label>検索</template>
    </v-text-field>

    <div v-for="ticket in searchTickets" :key="ticket.id">
      <v-row>
        <v-col cols="4">
          {{ ticket.customer_name }}
        </v-col>
        <v-col cols="4">
          {{ ticket.date }}
        </v-col>
        <v-col cols="4">
          {{ ticket.time }}
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="6">
          <count-ticket
            :id="ticket.id"
            :count="ticket.count"
            :tickets="tickets"
          ></count-ticket>
        </v-col>
        <v-col cols="4">
          <v-btn @click="updateStatus(ticket.contact_id, statusNum[ticket.status] + 1)">
            {{ statusLocales[ticket.status] }}
          </v-btn>
        </v-col>
        <v-col cols="2">
          <v-select
            v-model="submitStatus[`contact_${ticket.contact_id}`]"
            :items="selectStatus"
            :item-text="item => item.text"
            :item-value="item => item.num"
            filled
            @input="updateStatus(ticket.contact_id, submitStatus[`contact_${ticket.contact_id}`])"
          ></v-select>
        </v-col>
      </v-row>
    </div>

    <div style="text-align: center; margin-top: 2rem;">
      <v-btn elevation="2" @click="download">顧客一覧をダウンロードする</v-btn>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import CountTicket from './CountTicket.vue';

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

    props: {
      tickets: []
    },

    computed: {
      searchTickets: function(){
        if (this.keyword == "") return this.tickets

        return this.tickets.filter(ticket => {
          return ticket.customer_name.includes(this.keyword)
        })
      },
    },

    methods: {
      updateStatus: function(id, status){
        if (status > 3) { return }

        axios
          .put(`/contacts/${id}`, { contact: { status: status }})
          .then(response => {
            this.tickets.map(ticket => {
              if (ticket.contact_id == id) { ticket.status = response.data }
            })
          })
      },

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
