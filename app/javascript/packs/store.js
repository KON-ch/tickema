import Vue from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

export default new Vuex.Store({
  strict: process.env.RAILS_ENV !== "production",
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

    searchCustomers(state){
      return keyword => {
        return state.unbookedCustomers.filter(customer => {
          return customer.name.includes(keyword)
        })
      }
    }
  },

  mutations: {
    fetchCustomersInfo(state, res) {
      state.id = res.data.id
      state.title = res.data.title
      state.stages = res.data.stages
      state.schedules = res.data.schedules
      state.tickets = res.data.tickets
      state.unbookedCustomers = res.data.unbooked_customers
    },

    fetchStages(state, res) {
      state.stages = res.data.stages
    },

    addTicket(state, res) {
      state.tickets.push(res.data);
    },

    updateCount(state, payload) {
      state.tickets.find(ticket => ticket.id == payload.id).count = payload.count
    },

    deleteTicket(state, index) {
      state.tickets.splice(index, 1)
    },

    updateStatus(state, payload) {
      state.tickets.find(ticket => ticket.contact_id == payload.id).status = payload.status
    },

    deleteCustomer(state, index) {
      state.unbookedCustomers.splice(index, 1)
    }
  }
})
