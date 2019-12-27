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
  if @karaoke.save
    redirect "karaokes/#{@karaoke.id}"
  else
    erb :karaokes_new
  end
end

get "/karaokes/:id" do
  @karaoke = Karaoke.find(params[:id])
  erb :karaoke_show
end

get "/karaoke/:id/playlist" do
  @karaoke = Karaoke.find(params[:id])
  @playlists = Playlist.where(karaoke: @karaoke)
  erb :karaoke_playlists
end

get "/karaoke/:id/playlist/new" do
  @karaoke = Karaoke.find(params[:id])
  @songs = Song.all
  erb :karaoke_playlist_new
end

post "/karaoke/:id/playlist/update" do
  # @karaoke = Karaoke.find(params[:id])
  params.each do |key, value|
    if key.include? 'song'
      Playlist.create(song_id: value, karaoke_id: params[:id])
    end
  end
  redirect "karaoke/#{params[:id]}/playlist"
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
