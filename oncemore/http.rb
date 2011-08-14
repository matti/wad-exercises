require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

get "/hello/*" do
  name = params[:splat][0]
  
  output = "Hello, #{name}"
  
  if params[:with]
    output = output + " with #{params[:with]}"
  end
  
  return output
end


get "/" do
  uri = URI.parse( "http://localhost:4567/hello/somebody" ) 
  response = Net::HTTP.get_response(uri)
  response.body
end
