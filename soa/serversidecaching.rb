require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

require 'redis'


get '/' do
  redis = Redis.new

  value = redis.get "server_a_output"
  
  if not value
    uri = URI.parse( "http://localhost:10000/whoami" )    # create an instance of URI class
    response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a
    value = response.body
    
    redis.set "server_a_output", value
  end
  
  @from_server_a = value

  value = redis.get "server_b_output"
  
  if not value
    uri = URI.parse( "http://localhost:10001/whoami" )    # create an instance of URI class
    response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a
    value = response.body
    
    redis.set "server_b_output", value
  end

  @from_server_b = value
  
  uri = URI.parse( "http://localhost:10003/" )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a
  
  @from_chat = response.body

  erb :doublechat
end


post "/messages" do
  
  uri = URI.parse('http://localhost:10003/messages')
  res = Net::HTTP.post_form(uri, {'message' => params[:message] })
                                  
  redirect "/"
end