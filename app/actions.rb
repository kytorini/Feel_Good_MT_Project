helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

end

get '/' do
  erb :'/index'
end

get '/search' do
  erb :'/search'
end

get '/show' do
  @advice = Advice.order("RANDOM()").first
  erb :'/show'
end

get '/submit' do
  erb :'/submit'
end

post '/submit' do 
  @advice = Advice.new(
    category: "general",
    content: params[:content],
    user_id: params[:current_user]
  ) 
  current_user.advices << @advice
    if @advice.save
      session[:message] = "Submit successful"
      redirect "/profile"
    else 
      session[:message] = "Could not submit"
      redirect "/submit"
  end
end

get '/profile' do
 @advices = current_user.advices.order('created_at DESC')
 @bookmarks = current_user.bookmarks.order('created_at DESC')
 erb :'/profile'
end

post '/bookmark' do
  @bookmark = Bookmark.new(user_id: current_user.id, advice_id: params[:advice_id])
  if @bookmark.save
      session[:message] = "Bookmark successful"
      redirect "/profile"
    else 
      session[:message] = "Can only bookmark once"
      redirect "/show"
  end
end

get '/login' do
  @message = params['message']
  erb :'/login'
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if @user 
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      @message = "Login successful"
      redirect "/profile?message=#{@message}"
    else
      @message = "Invalid password"
      redirect "/login?message=#{@message}"
    end
  else
    @message = "Invalid username"
    redirect "/login?message=#{@message}"
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/signup' do
  erb :'/signup'
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      @message = "Account created"
      redirect "/profile"
    else
      erb :'/signup'
    end
end

post '/delete' do
  b = Bookmark.find(params[:bookmark_id])
  b.destroy 
  redirect '/profile'
end