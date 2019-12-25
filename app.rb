require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/karaoke'
require_relative 'models/song'
require_relative 'models/playlist'

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
  playlist = Playlist.create
  @karaoke.playlist_id = playlist.id
  if @karaoke.save
    redirect "karaokes/#{@karaoke.id}"
  else
    erb :"karaokes/new"
  end
end

get "/karaokes/:id" do
  @karaoke = Karaoke.find(params[:id])
  # @playlist =
  erb :"karaoke_show"
end

get "/songs/new" do
  @song = Song.new
  @karaoke = Karaoke.find(params[:karaoke_id])
  erb :song_new, layout: :my_layout
end

post "/songs" do
  @song = Song.new(params[:song])
  if @song.save!
    redirect "karaokes/#{params[:karaoke_id]}"
  else
    erb :"songs/new"
  end
end

get "/songs/:id" do
  @song = Song.find(params[:id])
  erb :song_show
end
