FactoryBot.define do
  factory :following do
    user
    following_user { create(:user) }
  end
end
