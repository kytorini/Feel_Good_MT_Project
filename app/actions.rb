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
    redirect '/'
  else 
    erb :'/submit'
  end
end

get '/bookmarks' do
  erb :'/user_id'
end

post '/bookmark' do
  @bookmark = Bookmark.new(user_id: current_user.id, advice_id: params[:advice_id])
  if @bookmark.save
      @message = "Bookmark successful"
      redirect "/show?message=#{@message}"
    else 
      @message = "Can only bookmark once"
      redirect "/show?message=#{@message}"
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
      redirect "/?message=#{@message}"
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