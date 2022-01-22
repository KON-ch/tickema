export const getters = {
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
}
