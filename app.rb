require 'sinatra'

get '/' do
  erb :home, layout: :my_layout
end

get '/cochon' do
  erb :cochon, layout: :my_layout
end


