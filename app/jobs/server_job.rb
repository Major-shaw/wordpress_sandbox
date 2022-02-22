class Server_job
  @queue = :server_job

  def self.perform(site)
    db_created = create_database(site)
    puts "db created: ", db_created
    container_created = create_container(site)
    puts "container created: ", container_created
  end

  def self.create_database(site)
    response = RestClient::Request.execute(method: :post, url: 'http://localhost:8080', payload: site.to_json, 
                                          headers: {"Content-Type" => "application/json"})
    return response.code
  end

  def self.create_container(site)
    response = RestClient::Request.execute(method: :post, url: 'http://localhost:8080', payload: site.to_json, 
                                           headers: {"Content-Type" => "application/json"})
    return response.code
  end

end
