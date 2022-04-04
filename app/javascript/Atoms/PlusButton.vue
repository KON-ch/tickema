<template>
  <span>
    <v-btn v-on:click="plusCount(id, count)" class="plus-btn" icon>
      <v-icon>mdi-plus</v-icon>
    </v-btn>
  </span>
</template>

<script>
import axios from 'axios';

export default {
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
    },
  },

  methods: {
    plusCount: function(id, count) {
      if (!isFinite(count)) {
        const errorMessage = "枚数に不正な値が入力されています"
        console.log(errorMessage)
        return this.errors = errorMessage
      }

      axios
        .patch(`/reservations/${id}/count`, { reservation: { count: count + 1} })
        .then(this.$store.commit("updateCount", { id: id, count: count + 1 }))
    }
  }
}
</script>

