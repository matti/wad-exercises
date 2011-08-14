require 'sinatra'
require 'sinatra/reloader'

get "/hello/*" do
  name = params[:splat][0]
  
  output = "Hello, #{name}"
  
  if params[:with]
    output = output + " with #{params[:with]}"
  end
  
  return output
end
