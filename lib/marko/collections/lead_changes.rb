class Marko::Client::LeadChanges < Cistern::Collection
  model Marko::Client::LeadChange

  def all(params={})
    data = connection.get_lead_changes(params).body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end
end
