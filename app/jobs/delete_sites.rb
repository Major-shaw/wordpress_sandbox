class Delete_sites
  @queue = :delete

  def self.perform
    Site.all.each do |site|
      if site.status == 'deleted'
        response = delete_sites(site)
        if response == 200
          site.update_attributes(:status => "removed")
          puts "site deleted: ", response
        end
      end
    end
  end

  def self.delete_sites(site)
    response = RestClient::Request.execute(method: :delete, url: 'http://206.189.138.203:47157',payload: site.to_json,
                                           headers: {"Content-Type" => "application/json"})
    return response.code
  rescue Errno::ECONNREFUSED
    return 500
  rescue RestClient::ExceptionWithResponse => e
   return e.response.code
  end

end
