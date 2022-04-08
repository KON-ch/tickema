<template>
  <v-select
    @input="item => $emit('input', item)"
    :value="value"
    :items="countItems"
    background-color="white"
    dense
    flat
    label="枚数"
    solo
    suffix="枚"
  />
</template>

<script>
export default {
  data: function() {
    return {
      countItems: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
  },
  props: {
    value: {
      type: Number,
      default: 1
    }
  }
}
</script>

