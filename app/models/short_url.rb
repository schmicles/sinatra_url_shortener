require 'net/http'

class ShortUrl < ActiveRecord::Base
  # Remember to create a migration!
  validates :long_url, presence: true
  validates_format_of :long_url, :with => URI::regexp(%w(http https))
  validate :valid_url


  def valid_url
    # url = URI.parse(:long_url)
    # puts url
    # req = Net::HTTP.new(url.host)
    # puts req
    # res = req.request_head(url.path)
    # puts res
    # if res.code != "200"
    #   errors.add(:long_url, "invalid url")
    # end
    url = URI.parse(long_url)

    puts "============================================="
    puts url
    # if url != nil
      # Net::HTTP.get(url)
      # html = Net::HTTP.get(url)
    begin
      response_code = Net::HTTP.get_response(url).code
      puts response_code
      puts response_code[0]
      # puts response_code
      if response_code[0].to_i >= 4 || response_code == nil
        errors.add(:long_url, "cannot access page")
      end
    rescue
      errors.add(:long_url, "bad url")
    end
    # else
      # errors.add(:long_url, "bad url")
    # end

  end

end
