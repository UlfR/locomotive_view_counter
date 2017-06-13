require 'locomotive/steam'

require_relative 'locomotive/view_counter'

Locomotive::Steam.configure_extension do |config|
	have_mw = config.middleware.list.select{|x| x[0][0] == Locomotive::ViewCounter::Middleware }.present?
	Rails.logger.fatal "ViewCount MIDDLEWARE INIT, #{have_mw}"
  config.middleware.insert_after(Locomotive::Steam::Middlewares::TemplatizedPage, Locomotive::ViewCounter::Middleware) unless have_mw
end
