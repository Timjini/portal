module MailSender
  
  def send(email,subject, html)
    sender = 'mailgun@sandboxed4eba1df4d24a458e716e80e4600342.mailgun.org'
    # Mailgun API endpoint
    url = URI.parse("https://api.mailgun.net/v3/sandboxed4eba1df4d24a458e716e80e4600342.mailgun.org/messages")

    # Create HTTP object
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # Use SSL for HTTPS

    # Prepare the request
    request = Net::HTTP::Post.new(url.request_uri)
    request.basic_auth("api", "#{ENV['MAILGUN_API']}")
    request['Content-Type'] = 'application/x-www-form-urlencoded'

    # Set the parameters for the email
    request.set_form_data(
    from: sender,
    to: email,
    subject: subject,
    html: html
  )
    # Send the request
    response = http.request(request)

    # Output response
    puts response.body
  end
end