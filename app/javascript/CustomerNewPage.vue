<template>
  <form @submit="createCustomer">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>姓</label>
      <input v-model="customer.family_name" type="text">
      <label>名</label>
      <input v-model="customer.first_name" type="text">
      <button type="submit">登録</button>
    </div>
  </form>
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
    methods: {
      createCustomer: function() {
        axios
          .post(`/customers`, { customer: this.customer })
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
