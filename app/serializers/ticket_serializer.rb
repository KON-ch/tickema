class TicketSerializer
  def initialize(reservation)
    @id = reservation.id
    @customer_id = reservation.customer_id
    @customer_name = reservation.customer_name
    @schedule_id = reservation.schedule_id
    @date = reservation.date
    @time = reservation.time
    @count = reservation.count
    @status = reservation.status
  end
end
