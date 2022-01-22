export const mutations = {
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
