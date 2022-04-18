class Server_job
  @queue = :server_job

  def self.perform(site_id)
    site = Site.find(site_id)
    response = create_site(site)
    puts "site created: ", response
    if response != 200
      site.update_attributes(:status => "deleted")
    end
  end

  def self.create_site(site)
    response = RestClient::Request.execute(method: :post, url: 'http://206.189.138.203:47157', payload: site.to_json, 
                                          headers: {"Content-Type" => "application/json"})
    return response.code
  rescue Errno::ECONNREFUSED
    return 500   
  rescue RestClient::ExceptionWithResponse => e
    return e.response.code
  end



end
