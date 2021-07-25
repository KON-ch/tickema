<template>
  <v-form @submit.prevent="$emit('submit')">
    <div v-if="errors.length">
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
  export default {
    props: {
      customer: {},
      errors: '',
    }
  }
</script>

<style scoped>
</style>
