class Server_job
  @queue = :server_job

  def self.perform(site_id)
    site = Site.find(site_id)
    db_created = create_database(site)
    puts "db created: ", db_created
    #container_created = create_container(site)
    #puts "container created: ", container_created
    #if container_created != 200 or db_created != 200
    if db_created != 200
      site.update_attributes(:status => "deleted")
    end
  end

  def self.create_database(site)
    response = RestClient::Request.execute(method: :post, url: 'http://206.189.138.203:47157', payload: site.to_json, 
                                          headers: {"Content-Type" => "application/json"})
    return response.code
  rescue Errno::ECONNREFUSED
    return 500   
  rescue RestClient::ExceptionWithResponse => e
    return e.response.code
  end

  def self.create_container(site)
    response = RestClient::Request.execute(method: :post, url: 'http://localhost:8080', payload: site.to_json, 
                                           headers: {"Content-Type" => "application/json"})
    return response.code
  rescue RestClient::ExceptionWithResponse => e
    return e.response.code
  end

end
