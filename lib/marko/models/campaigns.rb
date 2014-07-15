class Marko::Client::Campaigns < Cistern::Collection
  model Marko::Client::Campaign

  def all(params={})
    data = connection.get_campaigns(params).body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end

  def get(id)
    self.new(self.connection.get_campaign(id).body["result"].first)
  end
end
