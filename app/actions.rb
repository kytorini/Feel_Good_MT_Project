# Homepage (Root path)
get '/' do
  erb :'index'
end

get '/search' do
  erb :'search'
end

get '/show' do
  @advice = Advice.where(id: rand(0...Advice.count))
  unless @advice.empty?
    @advice = @advice[0].content
  erb :'/show'
end

get '/post' do
  erb :'post'
end

post '/post' do
  erb :'post'
end

get '/:user_id' do
  erb :'user_id'
end