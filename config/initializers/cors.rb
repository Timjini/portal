# frozen_string_literal: true

# cors file
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'http://localhost:3000'
    origins ['https://www.chambersforsport.com', 'https://www.chambersforsport.com/taster-sessions-booking.php',
             'http://localhost:3000', 'http://localhost:5173', 'https://4f1t.com', 'https://www.4f1t.com']
    resource '*', headers: :any, methods: %i[get post put patch delete options]
  end
end
