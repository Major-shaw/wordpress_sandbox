class Delete_sites
  @queue = :delete

  def self.perform
    Site.all.each do |site|
      if site.status == 'deleted'
        response = Site.delete(site)
        if response == 200
          site.update_attributes(:status => "removed")
          puts "site deleted: ", response
        end
      end
    end
  end

end
