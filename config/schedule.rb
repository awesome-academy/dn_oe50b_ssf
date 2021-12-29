
set :environment, "development"
set :output, "log/cron_error.log"

every "0 16 * * *" do
  puts "Sending notifications"
  rake "admin_notify:send_noti"
end
