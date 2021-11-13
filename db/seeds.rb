# test
# rails db:migrate:reset RAILS_ENV=test
# rails db:seed RAILS_ENV=test

# User
USER_NAME = "サンプル ユーザー"
User.create!(name: USER_NAME, email: ENV['TEST_USER_EMAIL'], password: ENV['TEST_USER_PASSWORD'])

user = User.find_by(name: USER_NAME)

TITLES = %w[サンプル・デビュー 試運転放浪記]

# Stage
TITLES.each do |title|
  user.stages.create!({ title: title })
end

# Schedule
month = 4

TITLES.each do |title|
  dates  = Date.new(2021, month, 10)..Date.new(2021, month, 24)

  dates.each_with_index do |date, idx|
    if idx.odd?
      hour = 18
    else
      hour = 13
    end

    Stage.find_by(title: title).schedules.create!(staged_on: date, staged_at: Time.new(2021, 1, 1, hour, 30, 0, "+09:00"))
  end

  month += 3
end

# Customer
LAST_NAMES = %w[佐藤 鈴木 高橋 田中 渡辺 伊藤 山本 中村 山田 小林]
FIRST_NAMES  = %w[正一 清 正雄 茂 武雄 愛 彩 美里 成美 沙織]

LAST_NAMES.each do |last_name|
  FIRST_NAMES.each do |first_name|
    user.customers.create!(name: "#{last_name} #{first_name}")
  end
end

# Ticket
customer_size = 25

TITLES.each do |title|
  stage = Stage.find_by(title: title)

  user.customers.shuffle.first(customer_size).each do |customer|
    schedule_id = stage.schedules.shuffle.first.id
    count       = (1..3).to_a.sample

    customer.tickets.create!(stage_id: stage.id, schedule_id: schedule_id, count: count)
  end

  customer_size += 10
end

# Contact
user.contacts.shuffle.first(50).each do |contact|
  status = (0..3).to_a.sample
  contact.update!(status: status)
end
