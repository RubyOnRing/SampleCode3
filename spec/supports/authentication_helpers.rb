module AuthenticationHelpers
  def login_as_user(user = nil)
    user ||= FactoryBot.create(:user)
    login_as(user, scope: :user, run_callbacks: false)
    user
  end
end
