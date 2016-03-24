# Homepage (Root path)
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
    user_id: 1,
  ) 
  if @advice.save
    redirect '/'
  else 
    erb :'/submit'
  end
end

get '/:user_id' do
  erb :'/user_id'
end