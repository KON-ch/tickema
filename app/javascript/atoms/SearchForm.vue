<template>
  <v-text-field
    :value="value"
    class="search-form"
    @input="value => $emit('input', value)"
    prepend-inner-icon="mdi-account-search-outline"
  >
    <template v-slot:label>検索</template>
  </v-text-field>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: ""
    }
  }
}
</script>

<style scoped>
.search-form {
  margin: 32px 24px;
}
</style>

