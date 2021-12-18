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
      <v-btn v-on:click="updateCount(id, count + 1)" icon>
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </span>
    <span>
      <v-btn @click="deleteTarget = id; showModal = true" icon>
        <v-icon class="trash-btn">mdi-trash-can-outline</v-icon>
      </v-btn>
    </span>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteTicket(deleteTarget); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
  import axios from 'axios';
  import Modal from './Modal.vue'

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
      id: 0,
      count: 0,
      tickets: []
    },

    methods: {
      updateCount: function(id, count) {
        if (!isFinite(count)) {
          const errorMessage = "枚数に不正な値が入力されています"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .put(`/tickets/${id}`, { ticket: { count: count} })
          .then(this.tickets.find(ticket => ticket.id == id).count = count)
      },

      deleteTicket: function(id) {
        const index = this.tickets.findIndex(ticket => { return ticket.id == id })

        if (index == -1) {
          const errorMessage = "削除できませんでした"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .delete(`/tickets/${id}`)
          .then(this.tickets.splice(index, 1))
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
  margin-left: 1rem;
}

.trash-btn {
  margin-right: 1rem;
}
</style>
