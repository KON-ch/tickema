<template>
  <div>
    <span v-if="count > 1" >
      <v-btn v-on:click="updateCount(id, count - 1)" class="minus_btn" icon>
        <v-icon>mdi-minus</v-icon>
      </v-btn>
    </span>
    <span v-else>
      <v-icon class="minus_btn no_active">
        mdi-minus
      </v-icon>
    </span>
    <span style="font-weight: bold;">
      {{ count }}枚
    </span>
    <span>
      <v-btn v-on:click="updateCount(id, count + 1)" icon>
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </span>
    <span class="trash_btn">
      <v-btn @click="deleteTarget = id; showModal = true" icon>
        <v-icon>mdi-trash-can-outline</v-icon>
      </v-btn>
    </span>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteTicket(deleteTarget); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
  import axios from 'axios';
  import Modal from 'Modal.vue'

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
          .then(this.tickets.map(ticket => {
            if (ticket.id == id) { ticket.count = count }
          }))
      },

      deleteTicket: function(id) {
        const index = this.tickets.map((ticket, index) => { if(ticket.id == id){ return index } }).filter(Boolean)

        if (index.length != 1) {
          const errorMessage = "削除できませんでした"
          console.log(errorMessage)
          return this.errors = errorMessage
        }

        axios
          .delete(`/tickets/${id}`)
          .then(this.tickets.splice(index[0], 1))
      },
    }
  }
</script>

<style scoped>
.no_active {
  min-width: 36px;
  color: lightgray;
  margin-left: 1rem
}

.minus_btn {
  margin-left: 1rem;
}
</style>
