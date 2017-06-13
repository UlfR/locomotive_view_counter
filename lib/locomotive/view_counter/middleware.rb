module Locomotive
  module ViewCounter

    class Middleware

      def initialize(app)
        @app = app
      end

      def call(env) 
	Rails.logger.fatal('calling ViewCounter')
        if !env['steam.live_editing'] && entry = env['steam.content_entry']
	  Rails.logger.fatal('calling ViewCounter increment')
          increment_view_counter(entry, env.fetch('steam.services'))
        end

        @app.call(env)
      end

      private

      def increment_view_counter(entry, services)
        type = entry.content_type

        if type.fields_by_name[:views]
	  Rails.logger.fatal("calling ViewCounter have views, entity: #{entry}")
          repository = services.repositories.content_entry.with(type)
	  #begin
          x = repository.inc(entry, :views)
	  Rails.logger.fatal("calling ViewCounter have views result: #{x.inspect}")
	  #rescue
	  #end
        end
      end

    end

  end
end
