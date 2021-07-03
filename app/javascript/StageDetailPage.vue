<template>
  <dl>
    <dt>ID</dt>
    <dd>{{ stage.id }}</dd>
    <dt>Title</dt>
    <dd>{{ stage.title }}</dd>
  </dl>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      stage: []
    }
  },
  mounted() {
    axios
      .get(`/stages/${this.$route.params.id}`)
      .then(response => (this.stage = response.data))
  }
}
</script>

<style scoped>
</style>
