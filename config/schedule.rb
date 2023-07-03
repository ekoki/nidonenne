# Rails.rootを使用するために必要

# スクリプトが実行されるときに、Railsの環境設定ファイルを読み込むように指示
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every :hour do
  rake 'notification_schedule:send_message'
end