<template>
  <v-card class="edit-body">
    <v-app-bar
      absolute
      height="64px"
    >
      <v-toolbar-title><h1 class="edit-title">顧客名編集</h1></v-toolbar-title>

      <v-spacer></v-spacer>

      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <v-card class="edit-items">
      <v-text-field v-model="keyword" class="search-form">
        <template v-slot:label>検索</template>
      </v-text-field>

      <v-form v-for="customer in searchCustomers" :key="customer.id">
        <template v-if="errors[`customer_${customer.id}`]">
          <div v-for="e in errors[`customer_${customer.id}`]" :key="e">
            <div><font color="red">{{ e }}</font></div>
          </div>
        </template>

        <v-row>
          <v-col cols="6" class="edit-form">
            <v-text-field
              v-model="customer.name"
              solo
              :background-color="formColor(customer.id)"
              :readonly="!editable[`customer_${customer.id}`]"
              :rules="[rules.name]"
            ></v-text-field>
          </v-col>

          <v-col cols="2">
            <v-btn @click="switchEditbale(customer.id)" class="edit-btn">編集</v-btn>
          </v-col>

          <v-col cols="2" class="edit-save">
            <v-btn
              @click="updateName(customer)"
              :disabled="!editable[`customer_${customer.id}`]"
            >保存</v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card>

    <user-menu
      :stages="stages"
      v-model="drawer"
    ></user-menu>
  </v-card>
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
        .catch(error => { console.error(error); });

      axios
        .get(`/mypage`)
        .then(response => (this.stages = response.data.stages))
        .catch(error => { console.error(error); });
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

<style scoped>
.edit-body {
  position:fixed;
  top: 0;
  right: 0;
  left: 0;
}

.edit-body::-webkit-scrollbar {
  display: none;
}

.edit-items {
  height: 100vh;
  overflow-y: scroll;
  padding: 6rem 1rem 10rem 1rem;
}

.edit-title {
  font-size: 1.5rem;
  color: #458d24;
}

.search-form {
  padding: 1rem 1rem 2rem;
}

.edit-form {
  font-size: 1.5rem;
  padding: 1rem 0 0 1.5rem;
}

.edit-btn {
  margin-right: 1rem;
  margin-top: 0.5rem;
}

.edit-save {
  margin-top: 0.5rem;
}
</style>
