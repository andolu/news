require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  #lat = 42.0574063
  #long = -87.6722787

  #units = "imperial" # or metric, whatever you like
  #key = "YOUR-API-KEY-GOES-HERE" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
 get "/" do
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=684e7ad713c20c1ca441de4ced86bb18"
# make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  puts "It is currently #{@forecast["current"]["temp"]} degrees and #{@forecast["current"]["weather"][0]["description"]}"
puts "Extended forecast:"
day_number = 1
for @day in @forecast["daily"]
if day_number < 9
  puts "On day #{day_number}, high of #{@day["temp"]["max"]} and #{@day["weather"][0]["description"]}"
else
  puts "Error"
end     
day_number = day_number + 1  
end

  # Get the news
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=3a10d9bb42124197992d092483afd88a"
@news = HTTParty.get(url).parsed_response.to_hash

for @story in @news["articles"]
  puts "Top stories today #{@story["title"]}"
end 
for @details in @news["articles"]
    puts "Content is #{@details["description"]}"
end 
for @url in @news["articles"]
    puts "The URL is #{@url["url"]}"
end

view 'news'
end
