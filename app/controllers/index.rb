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
      ShortUrl.create(long_url: long_url)
      url_id = ShortUrl.where(long_url: long_url).first.id
      redirect "/result/#{url_id}"
    else
      @error =
      erb :index
  end
end


get '/result/:url_id' do
  @short_url_id = params[:url_id]
  short_url_object = ShortUrl.where(id: @short_url_id).first
  @long_url = short_url_object.long_url
  @counter = short_url_object.counter
  erb :result
end

get '/:url_id' do
  @short_url_id = params[:url_id]
  short_url_object = ShortUrl.where(id: @short_url_id).first
  @long_url = short_url_object.long_url
  short_url_object.counter += 1
  short_url_object.save

  redirect @long_url
end

