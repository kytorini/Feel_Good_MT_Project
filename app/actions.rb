# Homepage (Root path)
get '/' do
  erb :'index'
end

get '/search' do
  erb :'search'
end

get '/search/:id' do
  erb :'search/show'
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