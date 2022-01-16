import axios from "axios";
import Vue from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

export default new Vuex.Store({
  strict: true,
  state: {
    id: 0,
    title: "",
    stages: [],
    schedules: [],
    tickets: [],
    unbookedCustomers: [],
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
    }
  }
})
