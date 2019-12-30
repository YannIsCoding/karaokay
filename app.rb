require 'sinatra'
require 'sinatra/activerecord'
require_relative 'app/models/karaoke'
require_relative 'app/models/song'
require_relative 'app/models/playlist'
require_relative 'app/models/user'
require_relative 'app/module/user_session'

helpers UserSession

enable :sessions

get '/' do
  @user = current_user
  erb :home, layout: :my_layout
end

get '/registration/signup' do
  erb :'registration/signup'
end

post '/registration' do
  @user = User.new(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
  if @user.save!
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'registration/signup'
  end
end

get '/session/login' do
  erb :'session/login'
end

post '/session' do
  @user = User.find_by(email: params[:user][:email])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'session/login'
  end
end

get '/session/destroy' do
  session.clear
  redirect '/'
end

get '/karaokes' do
  @karaokes = Karaoke.all
  erb :'karaoke/index', layout: :my_layout
end

get '/karaokes/new' do
  @karaoke = Karaoke.new
  erb :'karaoke/new', layout: :my_layout
end

post '/karaokes' do
  @karaoke = Karaoke.new(params[:karaoke])
  if @karaoke.save!
    redirect "karaokes/#{@karaoke.id}"
  else
    erb :'karaoke/new', layout: :my_layout
  end
end

get "/karaokes/:id" do
  @karaoke = Karaoke.find(params[:id])
  erb :'karaoke/show', layout: :my_layout
end

get "/karaoke/:id/playlist" do
  @karaoke = Karaoke.find(params[:id])
  @playlists = Playlist.where(karaoke: @karaoke)
  erb :karaoke_playlists, layout: :my_layout
end

get "/karaoke/:id/playlist/new" do
  @karaoke = Karaoke.find(params[:id])
  @songs = Song.all
  erb :karaoke_playlist_new, layout: :my_layout
end

post "/karaoke/:id/playlist/update" do
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
    erb :"songs/new", layout: :my_layout
  end
end

get "/songs/:id" do
  @song = Song.find(params[:id])
  erb :song_show, layout: :my_layout
end
