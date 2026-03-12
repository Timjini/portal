# frozen_string_literal: true

# cors file
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # allow do
  #   # origins 'http://localhost:3000'
  #   origins ['https://www.chambersforsport.com', 'https://www.chambersforsport.com/taster-sessions-booking.php',
  #            'http://localhost:3000', 'https://website.chambersforsport.com/', 'http://localhost:5173', 'https://4f1t.com', 
  #            'https://www.4f1t.com']
  #   resource '*', headers: :any, methods: %i[get post put patch delete options], credentials: true
  # end

  allow do
    origins lambda { |origin, _env|
      # List your allowed domains here
      allowed = ['http://localhost:3000', 'https://www.chambersforsport.com', 'https://website.chambersforsport.com', 'https://www.4f1t.com']
      allowed.include?(origin)
    }

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options],
             credentials: true
  end
end
