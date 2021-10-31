<template>
  <div>
    <v-text-field v-model="keyword">
      <template v-slot:label>検索</template>
    </v-text-field>

    <div v-for="ticket in searchTickets" :key="ticket.id">
      {{ ticket.customer_name }}は{{ ticket.date }}の{{ ticket.time }}です
    </div>

    <div class="total_count">合計 {{ totalCount }} 枚</div>

    <v-list>
      <v-list-group v-for="schedule in schedules" :key="schedule.id">
        <template v-slot:activator>
          <v-list-item-title :class="setScheduleColor(schedule.staged_at)">
            <span class="schedule_list">
              {{ schedule.staged_on }}
              {{ schedule.staged_at }}
            </span>
            <span class="schedule_count">{{ countPerSchedule(schedule.id) }}人</span>
          </v-list-item-title>
        </template>
        <v-list-item>
          <v-list-item-content>
            <stage-schedule
              :id="id"
              :schedule_id="schedule.id"
              :tickets="tickets"
            ></stage-schedule>
          </v-list-item-content>
        </v-list-item>
      </v-list-group>

    </v-list>
  </div>
</template>

<script>
  import StageSchedule from './StageSchedule.vue';

  export default {
    components: {
      StageSchedule,
    },

    data: function() {
      return {
        keyword: "",
      }
    },

    props: {
      id: 0,
      schedules: [],
      tickets: []
    },

    computed: {
      totalCount: function() {
        let count = 0
        this.tickets.forEach(ticket => {
          count += ticket.count
        })
        return count
      },

      countPerSchedule: function(){
        return function(schedule_id) {
          let count = 0
          this.tickets.forEach(ticket => {
            if (ticket.schedule_id == schedule_id) count += ticket.count
          })
          return count
        }
      },

      searchTickets: function(){
        if (this.keyword == "") return {}
        return this.tickets.filter(ticket => {
          return ticket.customer_name.includes(this.keyword)
        })
      },

      setScheduleColor: function() {
        return function(time) {
          if(time < '15:00') {
            return "schedule_matinee"
          } else {
            return "schedule_soiree"
          }
        }
      },
    }
  }

</script>
