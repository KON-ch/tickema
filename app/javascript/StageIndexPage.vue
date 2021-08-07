<template>
  <div>
    <div>Index</div>
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <th>title</th>
        </tr>
        <tr v-for="s in stages" :key="s.id">
          <td><router-link :to="{ name: 'StageDetailPage', params: { id: s.id } }">{{ s.id }}</router-link></td>
          <td>{{ s.title }}</td>
          <td>
            <button @click="deleteTarget = s.id; showModal = true">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <v-btn v-on:click="signOut">ログアウト</v-btn>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteStage(); showModal = false;">
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
  data: function () {
    return {
      stages: [],
      showModal: false,
      deleteTarget: -1,
      errors: '',
    }
  },
  mounted() {
    axios
      this.updateStage();
  },
  methods: {
    deleteStage: function() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }

      axios
        .delete(`/stages/${this.deleteTarget}`)
        .then(response => {
          this.deleteTarget = -1;
          this.updateStage();
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateStage: function() {
      axios
        .get(`/stages`)
        .then(response => (this.stages = response.data))
    },
    signOut: function() {
      axios.delete(`/users/sign_out`)
    },
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
