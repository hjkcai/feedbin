source "https://rubygems.org"

# load first so environment is initialized
gem "dotenv-rails", "= 2.8.1"

# 以下仓库在部署时需要带上 feedbin 自己的分支，原先走 github: 来源。
# 为避免构建期访问 GitHub，这里指向 projects/git-gems 下的本地 submodule 副本，
# 版本仍由 Gemfile.lock 固定；换回 GitHub 只需恢复 github: 参数。
gem "llhttp", path: "../../projects/git-gems/llhttp/mri"

gem "rails", "8.1.4.1"
gem "will_paginate"

gem "http",            path: "../../projects/git-gems/http"
gem "carrierwave",     path: "../../projects/git-gems/carrierwave"
gem "sax-machine",     path: "../../projects/git-gems/sax-machine"
gem "feedjira",        path: "../../projects/git-gems/feedjira"
gem "feedkit",         path: "../../projects/git-gems/feedkit"
gem "twitter",         path: "../../projects/git-gems/twitter"
gem "html-pipeline",   path: "../../projects/git-gems/html-pipeline"
gem "html_diff",       path: "../../projects/git-gems/html_diff"
gem "twitter-text",    path: "../../projects/git-gems/twitter-text/rb"
gem "librato-metrics", path: "../../projects/git-gems/librato-metrics"
gem "librato-rails",   path: "../../projects/git-gems/librato-rails"

gem "activerecord-import"
gem "addressable", require: "addressable/uri"
gem "apnotic"
gem "autoprefixer-rails"
gem "bcrypt"
gem "bootsnap", require: false
gem "clockwork"
gem "coffee-rails"
gem "concurrent-ruby"
gem "connection_pool", "< 3"
gem "cgi"
gem "evernote_oauth"
gem "fog-aws"
gem "honeybadger"
gem "htmlentities"
gem "image_processing"
gem "importmap-rails"
gem "jbuilder"
gem "jquery-rails"
gem "jwt"
gem "lograge"
gem "mail"
gem "oauth"
gem "oauth2"
gem "ostruct"
gem "pg"
gem "phlex-rails"
gem "postmark-rails"
gem "premailer-rails"
gem "pitchfork"
gem "redcarpet"
gem "redis", "< 5"
gem "requestjs-rails"
gem "reverse_markdown"
gem "ruby-vips"
gem "rubyzip", require: "zip"
gem "sanitize"
gem "sass-rails"
gem "sidekiq"
gem "stimulus-rails"
gem "stringio"
gem "stripe", "~> 5.55.0"
gem "stripe_event"
gem "strong_migrations", "< 2"
gem "tailwindcss-ruby", "< 4"
gem "tailwindcss-rails", "< 4"
gem "web-push"
gem "zstd-ruby"
gem "autotuner"

group :development do
  gem "benchmark-ips"
  gem "ruby-prof"
  gem "better_errors"
  gem "binding_of_caller"
  gem "foreman"
end

group :development, :test do
  gem "stripe-ruby-mock", path: "../../projects/git-gems/stripe-ruby-mock", require: "stripe_mock"
  gem "byebug", platforms: [:mri, :windows]
  gem "capybara"
  # Load only the prelude so binding.break works without starting a debugger
  # session during Rails boot. The full session installs fork/at_exit hooks
  # that can wait on test child processes such as the local redis-server.
  gem "debug", require: "debug/prelude"
  gem "faker"
  gem "minitest"
  gem "minitest-mock"
  gem "minitest-stub-const"
  gem "minitest-stub_any_instance"
  gem "rails-controller-testing"
  gem "cuprite"
  gem "standard"
  gem "webmock"
  gem "puma"
end
