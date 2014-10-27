require 'net/http'
require 'securerandom'

class ShortUrl < ActiveRecord::Base
  # Remember to create a migration!
  validates :long_url, presence: true
  validates_format_of :long_url, :with => URI::regexp(%w(http https))
  validate :valid_url
  before_save :generate_short_url

  def valid_url
    url = URI.parse(long_url)

    puts "============================================="
    puts url

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
  end

  def generate_short_url
    if self.counter == 0
      while ShortUrl.exists?(:generated_url => self.generated_url)
      self.generated_url = SecureRandom.urlsafe_base64(6)
      end
    end
  end

end
