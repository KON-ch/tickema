<template>
  <v-text-field
    :value="value"
    dense
    @input="value => $emit('input', value)"
  >
    <template v-slot:label>{{ labelText }}</template>
  </v-text-field>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: ""
    },
    labelText: {
      type: String,
      default: ""
    }
  }
}
</script>
