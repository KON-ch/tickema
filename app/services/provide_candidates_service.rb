class ProvideCandidatesService
  def initialize(user_id:, stage_id:)
    @user_id = user_id
    @stage_id = stage_id
  end

  def list
    user_customers = Customer.where(user_id: user_id).select(:id, :name)
    user_customers - user_customers.reserved(stage_id)
  end

  private attr_reader :user_id, :stage_id
end
