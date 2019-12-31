require 'sinatra'
require 'sinatra/activerecord'
require_relative 'app/models/karaoke'
require_relative 'app/models/song'
require_relative 'app/models/playlist'
require_relative 'app/models/vote'
require_relative 'app/models/player'
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
  redirect '/session/login' unless current_user
  @karaoke = Karaoke.new
  erb :'karaoke/new', layout: :my_layout
end

post '/karaokes' do
  redirect '/session/login' unless current_user
  @karaoke = Karaoke.new(params[:karaoke])
  @karaoke.user = current_user
  if @karaoke.save!
    redirect "karaokes/#{@karaoke.id}"
  else
    erb :'karaoke/new', layout: :my_layout
  end
end

get "/karaokes/:id" do
  redirect '/session/login' unless current_user
  @karaoke = Karaoke.find(params[:id])
  @playlists = Playlist.where(karaoke: @karaoke)
  @players = Player.where(karaoke: @karaoke)
  erb :'karaoke/show', layout: :my_layout
end

get "/karaoke/:id/playlist/new" do
  redirect '/session/login' unless current_user
  @karaoke = Karaoke.find(params[:id])
  @songs = Song.all
  erb :'playlist/new', layout: :my_layout
end

post "/karaoke/:id/playlist/create" do
  redirect '/session/login' unless current_user
  params.each do |key, value|
    if key.include? 'song'
      Playlist.create(song_id: value, karaoke_id: params[:id])
    end
  end
  redirect "karaokes/#{params[:id]}"
end

get '/karaoke/:id/new_players' do
  redirect '/session/login' unless current_user
  @karaoke = Karaoke.find(params[:id])
  @users = User.all
  erb :'player/new'
end

post "/karaoke/:id/new_players" do
  redirect '/session/login' unless current_user
  params.each do |key, value|
    if key.include? 'user'
      Player.create(user_id: value, karaoke_id: params[:id])
    end
  end
  redirect "karaokes/#{params[:id]}"
end

get "/songs/new" do
  redirect '/session/login' unless current_user
  @song = Song.new
  @karaoke = Karaoke.find(params[:karaoke_id])
  erb :song_new, layout: :my_layout
end

post "/songs" do
  redirect '/session/login' unless current_user
  @song = Song.new(params[:song])
  if @song.save!
    redirect "karaokes/#{params[:karaoke_id]}"
  else
    erb :"songs/new", layout: :my_layout
  end
end

get "/songs/:id" do
  redirect '/session/login' unless current_user
  @song = Song.find(params[:id])
  erb :song_show, layout: :my_layout
end

get '/playlist/:id/vote' do
  redirect '/session/login' unless current_user
  playlist = Playlist.find(params[:id])
  player = Player.find_by(karaoke: playlist.karaoke, user: current_user)
  if (vote = Vote.find_by(playlist: playlist, player: player))
    vote.destroy
  else
    Vote.create(player: player, playlist: playlist)
  end
  redirect "karaokes/#{playlist.karaoke.id}"
end
