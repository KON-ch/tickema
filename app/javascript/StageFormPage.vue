<template>
  <form @submit.prevent="$emit('submit')">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>作品名</label>
      <input v-model="stage.title" type="text">
      <button type="submit">登録</button>
    </div>
  </form>
</template>

<script>
  export default {
    props: {
      stage: {},
      errors: ''
    }
  }
</script>

<style>
</style>
