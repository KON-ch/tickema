<template>
  <div>
    <minus-button :id="id" :count="count" />
    <span style="font-weight: bold;">
      {{ count }}枚
    </span>
    <plus-button :id="id" :count="count" />
  </div>
</template>

<script>
import PlusButton from '../atoms/PlusButton.vue'
import MinusButton from '../atoms/MinusButton.vue'

export default {
  components: {
    PlusButton,
    MinusButton,
  },

  props: {
    // reservationId
    id: {
      type: Number,
      default: 0
    },
    // reservationCount
    count: {
      type: Number,
      default: 0
    }
  }
}
</script>

