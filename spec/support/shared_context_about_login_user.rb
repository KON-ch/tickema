shared_context "user is logged in" do
  before do
    user = create(:user)
    sign_in user
  end
end

shared_context "logged in user is sample" do
  before do
    user = create(:sample_user)
    sign_in user
  end
end

