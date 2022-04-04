shared_context "user is logged in" do
  before do
    user = create(:user)
    sign_in user
  end
end

shared_context "not logged in user is redirect" do
  before { create(:user) }

  it { expect(response).to have_http_status(302) }
end

shared_context "login sample user" do
  let(:user) { create(:user, :sample_user) }

  before { sign_in user }
end
