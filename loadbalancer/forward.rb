require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

get '*' do
  server_a = "http://localhost:10000"
  path = params[:splat][0]      # Get the first member of the array

  uri = URI.parse( server_a + path )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a

  return response.body
end