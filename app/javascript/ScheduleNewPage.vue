<template>
  <form @submit="createSchedule">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>開始日</label>
      <input v-model="startDate" type="date">
      <label>終了日</label>
      <input v-model="endDate" type="date">
      <label>開演時間</label>
      <input v-model="startTime" type="time">
    </div>
    <table>
      <thead>
        <tr>
          <th></th>
          <th>{{ startTime }}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{ startDate }}</td>
          <td>
            <input type="checkbox">
          </td>
        </tr>
        <tr>
          <td>{{ endDate }}</td>
          <td>
            <input type="checkbox">
          </td>
        </tr>
      </tbody>
    </table>
    <div v-for="schedule in schedules" :key="schedule.id">
      <label>日付</label>
      <input v-model="schedule.staging_date" type="date">
      <label>時間</label>
      <input v-model="schedule.start_time" type="time">
    </div>
    <div>
      <button type="submit">登録</button>
    </div>
  </form>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        schedules: [{
          staging_date: '',
          start_time: '',
        },{
          staging_date: '',
          start_time: '',
        }],
        stage_id: this.$route.params.id,
        startDate: '',
        endDate: '',
        startTime: '',
        errors: ''
      }
    },
    methods: {
      createSchedule: function() {
        axios
          .post(`/schedules`, { schedule: this.schedules, stage_id: this.stage_id })
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
