<template>
  <stage-form-page :errors="errors" :stage="stage" @submit="createStage"></stage-form-page>
</template>

<script>
import axios from 'axios';
import StageFormPage from './StageFormPage.vue';

export default {
  components: {
    StageFormPage
  },
  data: function() {
    return {
      stage: {
        title: ''
      },
      errors: ''
    }
  },
  methods: {
    createStage: function() {
      axios
        .post(`/stages`, this.stage)
        .then(response => {
          let s = response.data;
          this.$router.push({ name: 'StageDetailPage', params: { id: s.id } });
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
