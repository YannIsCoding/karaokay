require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/karaoke'
get '/' do
  erb :home, layout: :my_layout
end

get '/karaokes' do
  @karaokes = Karaoke.all
  erb :karaokes, layout: :my_layout
end

get '/karaokes/new' do
  @karaoke = Karaoke.new
  erb :karaoke_new, layout: :my_layout
end

post '/karaokes' do
  @karaoke = Karaoke.new(params[:karaoke])
  if @karaoke.save
    redirect "karaokes/#{@karaoke.id}"
  else
    erb :"karaoke/create"
  end
end

get "/karaokes/:id" do
  @karaoke = Karaoke.find(params[:id])
  erb :"karaoke_show"
end
