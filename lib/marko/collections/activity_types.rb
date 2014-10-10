class Marko::Client::ActivityTypes < Cistern::Collection
  model Marko::Client::ActivityType

  def all(params={})
    data = connection.get_activity_types.body
    self.load(data["result"])
    self.merge_attributes(data)
    self
  end
end
