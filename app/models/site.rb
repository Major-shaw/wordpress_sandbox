class Site < ApplicationRecord

  def self.create_site
    @site = Site.new(
      php_version: '7.4',
      wp_version: '5.7.2',
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      name: site_name
    )
  end

  def self.site_name
    return LiterateRandomizer.word + rand(10000).to_s
  end

end
