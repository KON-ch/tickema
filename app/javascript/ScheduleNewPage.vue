<template>
  <form @submit="createSchedule">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>日付</label>
      <input v-model="schedule.staging_date" type="date">
      <label>時間</label>
      <input v-model="schedule.start_time" type="time">
      <button type="submit">登録</button>
    </div>
  </form>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        schedule: {
          staging_date: '',
          start_time: '',
        },
        stage_id: this.$route.params.id,
        errors: ''
      }
    },
    methods: {
      createSchedule: function() {
        axios
          .post(`/schedules`, { schedule: this.schedule, stage_id: this.stage_id })
          .then(response => { response.data })
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
