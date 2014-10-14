class Marko::Client::LeadChanges < Cistern::Collection
  model Marko::Client::LeadChange

  attribute :next_page_token, type: :string, aliases: 'nextPageToken'
  attribute :fields, type: :array

  def all(params={})
    data = connection.get_lead_changes(params).body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end
end
