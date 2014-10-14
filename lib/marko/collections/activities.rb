class Marko::Client::Activities < Cistern::Collection
  model Marko::Client::Activity

  def all(params={})
    data = connection.get_activities.body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end
end

