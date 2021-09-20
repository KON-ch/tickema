<template>
  <div>
    <header-menu :stage="stage"></header-menu>
    <v-text-field v-model="keyword" style="padding: 0 1rem;">
      <template v-slot:label>検索</template>
    </v-text-field>
    <v-data-table
      :headers="headers"
      :items="search_customers"
      :items-per-page="10"
      :disable-sort="true"
      :hide-default-header="true"
    >
      <template v-slot:[`item.contacted`]="{ item }">
        <v-simple-checkbox
          v-model="item.contacted"
          @click="changeContacted(item)"
        ></v-simple-checkbox>
      </template>
    </v-data-table>
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
      headers:[
        { text: "連絡済み", value: "contacted" },
        { text: "名前", value: "name" },
        { text: "観劇日", value: "schedule" }
      ],
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
      if (this.keyword === "") return this.stage.customers
      return this.stage.customers.filter(customer => {
        return customer.name.includes(this.keyword)
      })
    }
  },

  methods: {
    changeContacted: function(customer){
      axios
        .put(`customers/${customer.id}/contacted`, { customer: { schedule_id: customer.schedule_id, contacted: customer.contacted } })
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

<style>
  .v-data-table__mobile-table-row {
    border-bottom: thin solid rgba(0,0,0,.12);
  }
  .v-data-table__mobile-row {
    display: inline-block;
    margin-top: 2rem;
    align-items: center;
  }
  .theme--light.v-data-table>.v-data-table__wrapper>table>tbody>tr:not(:last-child)>td:last-child {
    border-bottom: none;
  }
</style>
