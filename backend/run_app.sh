#!/bin/sh
# 執行 whenever 來更新 crontab 設定
bundle exec whenever --update-crontab

# 啟動 cron
cron -f &

# 執行 Rails 服務器
rails server -b 0.0.0.0
