class Marko::Client::Lists < Cistern::Collection
  model Marko::Client::List

  def all(params={})
    data = connection.get_lists(params).body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end

  def get(id)
    self.new(self.connection.get_list(id).body["result"].first)
  end
end
