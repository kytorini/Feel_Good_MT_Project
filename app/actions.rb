helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  def popular_query(integer)
    query1 = Bookmark.select('distinct advice_id, count(advice_id) as count').group(:advice_id).reorder('count DESC')
    result = query1[integer].advice_id
    Advice.find(result).content
  end
  def weekly_quote
    weekly_quote_range = 1.days.ago.midnight...Date.tomorrow.midnight
    weekly_query = Bookmark.joins(:advice).select('distinct advice_id, count(advice_id) as count').where('advices.created_at' => weekly_quote_range).group(:advice_id).reorder('count DESC').take(1)
    if weekly_query.empty?
      @advice = "No advice is the best advice."
    else
      weekly_query_result = weekly_query[0].advice_id
      @advice = Advice.find(weekly_query_result).content
    end
    @advice
  end
  def daily_quote
    daily_quote_range = Date.today.midnight...Date.tomorrow.midnight
    daily_query = Bookmark.joins(:advice).select('distinct advice_id, count(advice_id) as count').where('advices.created_at' => daily_quote_range).group(:advice_id).reorder('count DESC').take(1)
    if daily_query.empty?
      @advice = "No advice is the best advice."
    else
      daily_query_result = daily_query[0].advice_id
      @advice = Advice.find(daily_query_result).content
    end
    @advice
  end
end

get '/' do
  erb :'/index'
end

get '/search' do
  erb :'/search'
end

get '/show' do
  @advice = Advice.order("RANDOM()").last
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
      session[:message] = "Oops!#{@advice.errors.full_messages[0]}"
      redirect "/submit"
    end
end

get '/profile' do
    if current_user
     @advices = current_user.advices.order('created_at DESC')
     @bookmarks = current_user.bookmarks.order('created_at DESC')
     @total_been_bookmarked = Advice.joins(:bookmarks).where(user_id: current_user.id).count
    end
  erb :'/profile'
end

get '/popular' do
  if current_user
    @users = User.order("points DESC").take(5)
  end
  erb :'/popular'
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

post '/flag' do
  @flag = Flag.new(user_id: current_user.id, advice_id: params[:advice_id])
  if @flag.save
      session[:message] = "Flag successful"
      redirect "/show"
    else 
      session[:message] = "Can only flag once"
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

post '/delete_bookmark' do
  b = Bookmark.find(params[:bookmark_id])
  session[:message] = "Bookmark Deleted!"
  b.destroy 
  session[:message] = "Delete successful"
  redirect '/profile'
end


post '/delete_advice' do
  a = Advice.find(params[:advice_id])
  session[:message] = "Advice Deleted!"
  a.destroy
  session[:message] = "Delete successful"
  redirect '/profile'
end














