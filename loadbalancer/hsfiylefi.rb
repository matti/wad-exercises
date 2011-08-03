require 'sinatra'
require 'sinatra/reloader'

require 'net/http'

enable :sessions


before do

  if not session[:server_for_this_session]
    servers = [ "http://www.hs.fi", "http://www.yle.fi" ]
    random_index_based_on_the_length_of_the_servers_array = rand(servers.length)

    session[:server_for_this_session] = servers[random_index_based_on_the_length_of_the_servers_array]    
  end

end


get '*' do

  path = params[:splat][0]      # Get the first member of the array

  uri = URI.parse( session[:server_for_this_session] + path )    # create an instance of URI class
  response = Net::HTTP.get_response(uri)    # do a HTTP GET from server a

  return response.body
end