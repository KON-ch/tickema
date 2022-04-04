<template>
  <span>
    <template v-if="count > 1" >
      <v-btn v-on:click="minusCount(id, count)" class="minus-btn" icon>
        <v-icon>mdi-minus</v-icon>
      </v-btn>
    </template>
    <template v-else>
      <v-icon class="minus-btn no-active">
        mdi-minus
      </v-icon>
    </template>
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
    minusCount: function(id, count) {
      if (!isFinite(count)) {
        const errorMessage = "枚数に不正な値が入力されています"
        console.log(errorMessage)
        return this.errors = errorMessage
      }

      axios
        .patch(`/reservations/${id}/count`, { reservation: { count: count - 1} })
        .then(this.$store.commit("updateCount", { id: id, count: count - 1 }))
    }
  }
}
</script>
