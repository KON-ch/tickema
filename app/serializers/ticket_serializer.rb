class TicketSerializer
  def initialize(ticket)
    @id = ticket.id
    @customer_id = ticket.customer_id
    @customer_name = ticket.customer_name
    @schedule_id = ticket.schedule_id
    @date = ticket.date
    @time = ticket.time
    @reservation_id = ticket.reservation.id
    @count = ticket.reservation.count
    @status = ticket.reservation.status
  end
end
