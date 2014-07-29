class Marko::Client::Leads < Cistern::Collection
  model Marko::Client::Lead

  attribute :next_page_token,  aliases: "nextPageToken"
  attribute :batch_size,       aliases: "batchSize"

  def all(params={})

    data = connection.get_leads(params).body

    self.load(data["result"])
    self.merge_attributes(data)
    self
  end

  def next_page
    data = connection.get_leads(nextPageToken: next_page_token).body

    self.load(data["result"])
    self.merge_attributes(data)
    self
  end

  def get(id)
    self.new(self.connection.get_lead(id).body["result"].first)
  end
end
