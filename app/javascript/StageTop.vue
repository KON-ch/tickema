<template>
  <div class="top">
    <template v-for="ticket in searchTickets">
      <div :key="ticket.id" class="ticket">
        <ticket-card :ticket="ticket" />
      </div>
    </template>

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
              :schedule="schedule"
            ></stage-schedule>
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>
  </div>
</template>

<script>
  import { mapGetters, mapState } from 'vuex';
  import TicketCard from './organisms/TicketCard.vue'
  import StageSchedule from './StageSchedule.vue';

  export default {
    components: {
      StageSchedule,
      TicketCard
    },

    props: {
      keyword: {
        type: String,
        default: null
      }
    },

    computed: {
      ...mapState(["schedules", "tickets"]),

      ...mapGetters(["totalCount"]),

      countPerSchedule() {
        return function(schedule_id) {
          return this.$store.getters.countPerSchedule(schedule_id)
        }
      },

      searchTickets() {
        if (this.keyword == ""){ return [] }
        return this.$store.getters.searchTickets(this.keyword)
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
.top > .ticket {
  margin: 32px 24px 0;
}

.top-body {
  padding: 0 1rem;
  margin-bottom: 10rem;
}

.ticket {
  margin: 32px 24px 0;
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
  margin:12px 24px 24px;
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
