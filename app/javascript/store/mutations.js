export const mutations = {
  fetchStagesInfo(state, res) {
    state.id = res.data.id
    state.title = res.data.title
    state.schedules = res.data.schedules
    state.tickets = res.data.tickets
    state.candidates = res.data.candidates
    state.stages = res.data.otherStages
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
    state.tickets.find(ticket => ticket.id == payload.id).status = payload.status
  },

  deleteCustomer(state, customerId) {
    const index = state.candidates.findIndex(customer => customer.id === customerId)
    state.candidates.splice(index, 1)
  }
}
