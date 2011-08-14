require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

get '/' do

  uri = URI.parse( "http://localhost:10000/whoami" )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a

  @from_server_a = response.body

  uri = URI.parse( "http://localhost:10001/whoami" )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a

  @from_server_b = response.body
  
  uri = URI.parse( "http://localhost:10003/" )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a
  
  @from_chat = response.body

  erb :composition
end


post "/messages" do
  
  uri = URI.parse('http://localhost:10003/messages')
  res = Net::HTTP.post_form(uri, {'message' => params[:message] })
                                  
  redirect "/"
end