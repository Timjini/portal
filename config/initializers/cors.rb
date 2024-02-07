# cors file 
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        # origins 'http://localhost:3000'
        origins ['https://www.chambersforsport.com', 'https://chambersforsport.com','http://localhost:3000']
        resource '*', headers: :any, methods:  [:get, :post, :put, :patch, :delete, :options]
    end
end