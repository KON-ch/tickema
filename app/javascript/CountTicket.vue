<template>
  <div>
    <template v-if="count > 1" >
      <v-btn v-on:click="updateCount(id, count - 1)" class="minus-btn" icon>
        <v-icon>mdi-minus</v-icon>
      </v-btn>
    </template>
    <template v-else>
      <v-icon class="minus-btn no-active">
        mdi-minus
      </v-icon>
    </template>
    <span style="font-weight: bold;">
      {{ count }}枚
    </span>
    <span>
      <v-btn v-on:click="updateCount(id, count + 1)" class="plus-btn" icon>
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </span>
    <span>
      <v-btn @click="deleteTarget = id; showModal = true" class="trash-btn" icon>
        <v-icon>mdi-trash-can-outline</v-icon>
      </v-btn>
    </span>
    <modal
      v-if="showModal"
      @cancel="showModal = false"
      @ok="deleteTicket(deleteTarget); showModal = false;"
    />
  </div>
</template>

<script>
  import axios from 'axios';
  import Modal from './Modal.vue'
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
      // ticket_id
      id: {
        type: Number,
        default: 0
      },
      // ticket_count
      count: {
        type: Number,
        default: 0
      },
    },

    computed: mapState(["tickets"]),

    methods: {
      // todo: outside mutation
      updateCount: function(id, count) {
        if (!isFinite(count)) {
          const errorMessage = "枚数に不正な値が入力されています"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .put(`/tickets/${id}`, { ticket: { count: count} })
          .then(this.$store.state.tickets.find(ticket => ticket.id == id).count = count)
      },

      // todo: outside mutation
      deleteTicket: function(id) {
        const index = this.tickets.findIndex(ticket => { return ticket.id == id })

        if (index == -1) {
          const errorMessage = "削除できませんでした"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .delete(`/tickets/${id}`)
          .then(this.$store.state.tickets.splice(index, 1))
      },
    }
  }
</script>

<style scoped>
.no-active {
  min-width: 36px;
  color: lightgray;
  margin-left: 1rem
}

.minus-btn {
  margin-left: 0;
}

.trash-btn {
  margin-right: 0.5rem;
}
</style>
