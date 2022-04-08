<template>
  <v-select
    :items="statusList"
    :value="status"
    attach
    chips
    flat
    solo
    @input="item => updateStatus(id, item)"
  >
    <template #selection="{ item }">
      <v-chip
        :color="setStatusColor( item.value )"
        text-color="white"
      >{{ item.text }}</v-chip>
    </template>
  </v-select>
</template>

<script>
import axios from 'axios';

export default{
  data: function() {
    return {
      statusList: [
        { value: 'reserved', text: '予約済み' },
        { value: 'applied', text: '申請済み' },
        { value: 'notified', text: '連絡済み' },
        { value: 'finished', text: 'お礼済み' },
      ],
    }
  },

  props: {
    // reservationId
    id: {
      type: Number,
      default: 0
    },
    // reservationStatus
    status: {
      type: String,
      default: ""
    }
  },

  computed: {
    setStatusColor: function() {
      return function(status) {
        switch(status) {
          case "reserved":
            return "indigo"
          case "applied":
            return "amber"
          case "notified":
            return "red";
          case "finished":
            return "teal"
        }
      }
    }
  },

  methods: {
    updateStatus: function(id, status){
      axios
        .patch(`/reservations/${id}/status`, { reservation: { status: status }})
        .then(res => {
          this.$store.commit("updateStatus", { id: id, status: res.data });
        })
    },
  }
}
</script>
