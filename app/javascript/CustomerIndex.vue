<template>
  <div>
    <v-app-bar
      absolute
      height="64px"
    >
      <v-toolbar-title><h1>顧客名編集</h1></v-toolbar-title>

      <v-spacer></v-spacer>

      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-form v-for="customer in searchCustomers" :key="customer.id">
      <template v-if="errors[`customer_${customer.id}`]">
        <div v-for="e in errors[`customer_${customer.id}`]" :key="e">
          <div><font color="red">{{ e }}</font></div>
        </div>
      </template>

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

    <user-menu
      :stages="stages"
      v-model="drawer"
    ></user-menu>
  </div>
</template>

<script>
  import axios from 'axios';
  import UserMenu from './UserMenu.vue'

  export default {
    components: {
      UserMenu
    },

    data: function() {
      return {
        customers: [],
        drawer: false,
        stages: [],
        keyword: "",
        editable: {},
        rules: {
          name: value => !!value || "名前を入力してください"
        },
        errors: []
      }
    },

    mounted() {
      axios
        .get(`/customers`)
        .then(response => (this.customers = response.data))

      axios
        .get(`/mypage`)
        .then(response => (this.stages = response.data.stages))
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
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.$set(this.errors, `customer_${id}`,error.response.data.errors)
            }
          });

        this.$set(this.editable, `customer_${id}`, false)
      },

      switchEditbale: function(id) {
        const editable = this.editable[`customer_${id}`]
        this.$set(this.editable, `customer_${id}`, !editable)
      },
    }
  }

</script>
