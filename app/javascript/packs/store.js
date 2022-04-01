import Vue from "vue"
import Vuex from "vuex"
import { getters } from "../store/getters"
import { mutations } from "../store/mutations"

Vue.use(Vuex)

export default new Vuex.Store({
  strict: process.env.RAILS_ENV !== "production",
  state: {
    id: 0,
    title: "",
    stages: [],
    schedules: [],
    tickets: [],
    candidates: [],
  },

  getters,
  mutations
})
