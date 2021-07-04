<template>
  <stage-form-page :errors="errors" :stage="stage" @submit="updateStage"></stage-form-page>
</template>

<script>
import axios from 'axios';

import StageFormPage from './StageFormPage.vue';

export default {
  components: {
    StageFormPage
  },
  data() {
    return {
      stage: {},
      errors: ''
    }
  },
  mounted () {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  },
  methods: {
    updateStage: function() {
      axios
        .patch(`/stages/${this.stage.id}`, this.stage)
        .then(response => {
          this.$router.push({ name: 'StageDetailPage', params: { id: this.stage.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
</style>
