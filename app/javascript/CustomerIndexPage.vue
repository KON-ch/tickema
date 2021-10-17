<template>
  <div>
    <header-menu :stage="stage"></header-menu>

    <v-text-field v-model="keyword" style="padding: 1rem 1rem 0 1rem;">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-simple-table>
      <template v-slot:default>
        <tbody v-for="(customer, index) in search_customers" :key="index">
          <tr :class="contactedColor(customer.contacted)">
            <td>
              <v-checkbox
                v-model="customer.contacted "
                @click="changeContacted(customer)"
              ></v-checkbox>
            </td>
            <td>{{ customer.name }}</td>
            <td>{{ customer.date }}</td>
            <td>{{ customer.count }}枚</td>
          </tr>
        </tbody>
    </template>
    </v-simple-table>
    <div style="text-align: center; margin-top: 2rem;">
      <v-btn elevation="2" @click="download">顧客一覧ダウンロード</v-btn>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import HeaderMenu from './HeaderMenu.vue';

export default {
  components: {
    HeaderMenu
  },

  data: function() {
    return {
      stage: {},
      keyword: "",
    }
  },

  watch: {
    $route(to) {
      axios
      .get(`/stages/${to.params.id}`)
      .then(response => (this.stage = response.data))
    }
  },

  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },

  computed: {
    search_customers: function(){
      if (this.keyword == "") return this.stage.customers
      return this.stage.customers.filter(customer => {
        return customer.name.includes(this.keyword)
      })
    },

    contactedColor: function() {
      return function(contacted) {
        if(contacted) {
          return "contacted_done"
        } else {
          return "contacted_not"
        }
      }
    }
  },

  methods: {
    changeContacted: function(customer){
      axios
        .put(`customers/${customer.id}/data`,
          {
            customer: { contacted: customer.contacted },
            schedule: { id: customer.schedule_id }
          }
        )
    },

    download: function() {
      axios
        .get(`customers/${this.$route.params.id}/csv`)
        .then(response => {
          const today = new Date();
          let month = today.getMonth()
          if(month < 10) {
            month = "0" + month
          } else {
            month = month
          }

          const fileURL = URL.createObjectURL(new Blob([response.data]));
          const fileLink = document.createElement("a");
          fileLink.href = fileURL;
          fileLink.setAttribute("download", "customers_" + month + today.getDate() + ".csv" );
          fileLink.click();
        })
        .catch(error => { alert("ダウンロードに失敗しました") })
    }
  }
}
</script>

<style scoped>
  td {
    border-bottom: thin solid rgba(0,0,0,.12);
  }
  .contacted_done {
    background-color: rgba(100, 100, 100, 0.5);
  }
  .contacted_not {
    background-color: rgba(255, 255, 0, 0.05);
  }
</style>
