<template>
  <div>
    <h1>顧客名編集</h1>

    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-form v-for="customer in searchCustomers" :key="customer.id">
      <v-text-field
        v-model="customer.name"
        solo
        :background-color="formColor(customer.id)"
        :readonly="!editable[`customer_${customer.id}`]"
        :rules="[rules.name]"
      ></v-text-field>
      <v-btn @click="switchEditbale(customer.id)">編集</v-btn>
      <v-btn
        @click="updateName(customer)"
        :disabled="!editable[`customer_${customer.id}`]"
      >保存</v-btn>
    </v-form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        customers: [],
        keyword: "",
        editable: {},
        rules: {
          name: value => !!value || "名前を入力してください"
        }
      }
    },

    mounted() {
      axios
        .get(`/customers`)
        .then(response => (this.customers = response.data))
    },

    computed: {
      searchCustomers: function(){
        if(this.keyword == "") { return this.customers }

        return this.customers.filter(customer => {
          return customer.name.includes(this.keyword)
        })
      },

      formColor: function() {
        return function(id) {
          return this.editable[`customer_${id}`] ? "#FCE4EC" : "white"
        }
      },
    },

    methods: {
      updateName: function(customer) {
        const id = customer.id
        const name = customer.name

        if(!name) { return }

        axios
          .put(`/customers/${id}`, { customer: { name: name } })
          .then(this.customers.find(customer => customer.id == id).name = name)

        this.$set(this.editable, `customer_${id}`, false)
      },

      switchEditbale: function(id) {
        const editable = this.editable[`customer_${id}`]
        this.$set(this.editable, `customer_${id}`, !editable)
      },
    }
  }

</script>
