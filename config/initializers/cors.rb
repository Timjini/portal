# cors file 
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        # origins 'http://localhost:3000'
        origins 'https://chambersforsport.com'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end