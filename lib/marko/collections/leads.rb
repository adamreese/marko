class Marko::Client::Leads < Cistern::Collection
  model Marko::Client::Lead

  attribute :action,           type: :string
  attribute :batch_size,       type: :integer, aliases: "batchSize"
  attribute :lookup_field,     type: :string,  aliases: "lookupField"
  attribute :next_page_token,  type: :string,  aliases: "nextPageToken"
  attribute :filter_type,      type: :string,  aliases: "filterType"
  attribute :filter_values,    type: :array,   aliases: "filterValues"

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

  def describe
    self.new(self.connection.describe_leads.body["result"].first)
  end
end
