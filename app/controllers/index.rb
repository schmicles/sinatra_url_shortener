get '/' do
  # Look in app/views/index.erb
  @short_url = ""
  erb :index
end

post '/' do
  long_url = params[:long_url]
  @short_url = ShortUrl.new(long_url: long_url)
  @error = ""
  if @short_url.save
      generated_url = ShortUrl.where(long_url: long_url).first.generated_url
      redirect "/result/#{generated_url}"
    else
      erb :index
  end
end


get '/result/:generated_url' do
  @generated_url = params[:generated_url]
  puts @generated_url
  short_url_object = ShortUrl.where(generated_url: @generated_url).first
  puts short_url_object.inspect
  @long_url = short_url_object.long_url
  @counter = short_url_object.counter
  erb :result
end

get '/:generated_url' do
  @generated_url = params[:generated_url]
  short_url_object = ShortUrl.where(generated_url: @generated_url).first
  @long_url = short_url_object.long_url
  short_url_object.counter += 1
  short_url_object.save

  redirect @long_url
end

