require 'net/http'
require 'uri'
require 'openssl'
require 'nokogiri'
require 'json'

url = URI.parse('https://data.opentrack.run/en-gb/x/2025/GBR/decopen/competitor/')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

res = http.get(url.request_uri)
html = res.body

doc = Nokogiri::HTML(html)

vue_script = doc.search('script').find { |s| s.text.include?('competitors:') }
script_text = vue_script.text

# extract competitors array (full block)
json_match = script_text.match(/competitors:\s*(\[[\s\S]*?\])(?=\s*[},])/)

if json_match.nil?
  puts 'Competitors JSON not found'
  exit
end

js_array = json_match[1]

# ---------------------------
# CONVERT JAVASCRIPT OBJECTS TO VALID JSON
# ---------------------------

# Quote keys: abc: -> "abc":
js_array.gsub!(/(\w+):\s/) { "\"#{Regexp.last_match(1)}\":" }

# Replace single quotes with double quotes
js_array.tr!('\'', '"')

# Remove trailing commas
js_array.gsub!(/,\s*([\]}])/, '\1')

# Parse JSON
competitors = JSON.parse(js_array)

puts JSON.pretty_generate(competitors)
File.write('competitors.json', JSON.pretty_generate(competitors))
puts "\nSaved to competitors.json"
