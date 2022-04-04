<template>
  <div>
    <v-btn @click="deleteTarget = id; showModal = true" class="trash-btn" icon>
      <v-icon>mdi-close-box-outline</v-icon>
    </v-btn>
    <modal
      v-if="showModal"
      @cancel="showModal = false"
      @ok="deleteTicket(deleteTarget); showModal = false;"
    />
  </div>
</template>

<script>
  import axios from 'axios';
  import Modal from '../Modal.vue';
  import { mapState } from 'vuex';

  export default {
    components: {
      Modal
    },

    data: function() {
      return {
        showModal: false,
        deleteTarget: -1,
      }
    },

    props: {
      // reservationId
      id: {
        type: Number,
        default: 0
      },
    },

    computed: mapState(["tickets"]),

    methods: {
      deleteTicket: function(id) {
        const index = this.tickets.findIndex(ticket => { return ticket.id == id })

        if (index == -1) {
          const errorMessage = "削除できませんでした"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .delete(`/reservations/${id}`)
          .then(this.$store.commit("deleteTicket", index))
      }
    }
  }
</script>
