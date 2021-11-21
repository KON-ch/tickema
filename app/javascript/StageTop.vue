<template>
  <div>
    <v-text-field v-model="keyword" class="search-form">
      <template v-slot:label>検索</template>
    </v-text-field>

    <v-card v-for="ticket in searchTickets" :key="ticket.id" class="search-card">
      <v-row class="search-content">
        <v-col cols="5" class="search-name">
            {{ ticket.customer_name }}
        </v-col>
        <v-col cols="4">
          {{ ticket.date }}
        </v-col>
        <v-col cols="3">
          {{ ticket.time }}
        </v-col>
      </v-row>
    </v-card>

    <div class="total-count">合計<span class="total-count_num" :class="countRank(totalCount)">{{ totalCount }}</span>枚</div>

    <v-list class="top-body">
      <v-list-group v-for="schedule in schedules" :key="schedule.id" class="schedule-list">
        <template v-slot:activator>
          <v-list-item-title class="schedule-list_title">
            <span class="schedule-date">
              {{ schedule.staged_on }}
            </span>
            <span :class="setScheduleColor(schedule.staged_at)">
              {{ schedule.staged_at }}
            </span>
            <span class="schedule-count">{{ countPerSchedule(schedule.id) }}人</span>
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
            return "schedule-matinee"
          } else {
            return "schedule-soiree"
          }
        }
      },

      countRank: function() {
        return function(count) {
          if(count < 10) {
            return ""
          } else if( count < 20) {
            return "count-rank_silver"
          } else if( count < 30) {
            return "count-rank_gold"
          } else if( count < 50) {
            return "count-rank_platinum"
          } else {
            return "count-rank_diamond"
          }
        }
      }
    }
  }

</script>

<style scoped>
.top-body {
  padding: 0 1rem;
  margin-bottom: 10rem;
}

.search-form {
  padding: 2rem 2rem 1rem;
}

.search-card {
  text-align: center;
  margin: 1rem;
}

.search-content {
  padding: 0.5rem;
  margin-bottom: 1rem;
}

.search-name {
  font-size: 1.25rem;
  font-weight: bold;
}

.total-count {
  text-align: right;
  margin: 0 2rem 1rem;
}

.total-count_num {
  font-weight: bold;
  font-size: 1.5rem;
  padding: 0.5rem 1rem;
  margin: 0 1rem;
  border-radius: 1rem;
}

.count-rank_silver {
  background-color: silver
}

.count-rank_gold {
  background-color: gold;
}

.count-rank_platinum {
  background-color: blue;
  color: white;
}

.count-rank_diamond {
  background-color: black;
  color: white;
}

.schedule-list {
  margin-bottom: 1rem;
}

.schedule-list_title {
  font-size: 1.25rem;
}

.schedule-date {
  font-weight: bold;
}

.schedule-matinee {
  color:orange;
}

.schedule-soiree {
  color: blue;
}

.schedule-count {
  margin-left: 1rem;
}
</style>
