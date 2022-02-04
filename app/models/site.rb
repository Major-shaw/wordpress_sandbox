class Site < ApplicationRecord

  def self.create_site
    @site = Site.new(
      php_version: '7.4',
      wp_version: '5.7.2',
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      url: create_url
    )
  end

  def self.create_url
    word = LiterateRandomizer.word
    url = 'https://' + word + '.blogvault.com'
    return url if Site.where(:status => "running", :url => url).length() == 0
    create_url
  end

end
