<template>
  <v-form @submit="createCustomer" style="margin-top: 2rem">
    <template v-if="errors.length">
      <div v-for="e in errors" :key="e">
        <div><font color="red">{{ e }}</font></div>
      </div>
    </template>
    <v-row style="margin-left: 1rem">
      <v-col>
        <v-text-field v-model.trim="lastName" class="form-last_name">
          <template v-slot:label>姓</template>
        </v-text-field>
      </v-col>
      <v-col>
        <v-text-field v-model.trim="firstName" class="form-first_name">
          <template v-slot:label>名</template>
        </v-text-field>
      </v-col>
      <v-col>
        <v-btn type="submit" class="create-btn" icon>
          <v-icon x-large class="customer-btn">mdi-account-multiple-plus</v-icon>
        </v-btn>
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        lastName: "",
        firstName: "",
        errors: [],
      }
    },

    props: {
      id: 0,
      schedule_id: 0,
      tickets: []
    },

    methods: {
      createCustomer: function() {
        if(!this.lastName && !this.firstName) {
          this.errors = []
          return this.errors.push("名前を入力してください")
        }

        const name = this.lastName + " " + this.firstName

        axios
          .post(`/customers`,
            {
              customer: { name: name },
              ticket:   { stage_id: this.id, schedule_id: this.schedule_id }
            }
          )
          .then(response => {
            this.tickets.push(response.data);

            if (this.$route.params.id != this.id ){
              this.$router.push({ path: `/stages/${this.stage_id}` });
            };

            this.errors = '';
          })
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });

        this.lastName = "";
        this.firstName = "";
      },
    }
  }
</script>

<style scoped>
.customer-btn {
  margin-top: 1rem;
}
</style>
