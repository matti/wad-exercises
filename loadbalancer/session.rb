require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

enable :sessions

get '/session' do
  session[:testing] = "hello"
end

get '*' do

  servers = [ "http://localhost:10000", "http://localhost:10001" ]
  random_index_based_on_the_length_of_the_servers_array = rand(servers.length)
  server = servers[random_index_based_on_the_length_of_the_servers_array]
  
  path = params[:splat][0]      # Get the first member of the array

  uri = URI.parse( server + path )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a

  return response.body
end