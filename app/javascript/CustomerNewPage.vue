<template>
  <v-form @submit="createCustomer">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <v-row>
      <v-col>
        <v-text-field v-model="customer.family_name">
          <template v-slot:label>姓</template>
        </v-text-field>
      </v-col>
      <v-col>
        <v-text-field v-model="customer.first_name">
          <template v-slot:label>名</template>
        </v-text-field>
      </v-col>
      <v-col>
        <v-btn type="submit">登録</v-btn>
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        customer: {
          family_name: '',
          first_name: '',
        },
        errors: ''
      }
    },
    props: ['id'],
    methods: {
      createCustomer: function() {
        axios
          .post(`/customers`, { customer: this.customer, schedule_id: this.id })
          .then(response => { response.data })
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      }
    }
  }
</script>

<style scoped>
</style>
