import axios from "axios";
import Vue from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

export default new Vuex.Store({
  // todo: 本番環境ではfalseにする
  strict: true,
  state: {
    id: 0,
    title: "",
    stages: [],
    schedules: [],
    tickets: [],
    unbookedCustomers: [],
  },

  getters: {
    totalCount(state) {
      let count = 0
      state.tickets.forEach(ticket => {
        count += ticket.count
      })
      return count
    },

    countPerSchedule(state){
      return schedule_id => {
        let count = 0
        state.tickets.forEach(ticket => {
          if (ticket.schedule_id == schedule_id) { count += ticket.count }
        })
        return count
      }
    },

    searchTickets(state){
      return keyword => {
        return state.tickets.filter(ticket => {
          return ticket.customer_name.includes(keyword)
        })
      }
    },
  },

  mutations: {
    fetchCustomersInfo(state, { id }) {
      axios
        .get(`/stages/${id}`)
        .then((res) =>{
          state.id = res.data.id
          state.title = res.data.title
          state.stages = res.data.stages
          state.schedules = res.data.schedules
          state.tickets = res.data.tickets
          state.unbookedCustomers = res.data.unbooked_customers
        })
        .catch((e) => {
          console.error(e)
        })
    },

    addCustomer(state, payload) {
      state.tickets.push(payload.data);
    }
  }
})
