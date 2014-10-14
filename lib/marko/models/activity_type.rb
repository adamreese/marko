class Marko::Client::ActivityType < Marko::Model
  identity :id

  attribute :name, type: :string
  attribute :description, type: :string
  attribute :primary_attribute, squash: ["primaryAttribute", "name"], type: :string
  attribute :activity_attributes, aliases: "attributes", type: :array, parser: lambda { |v,_| [v.map(&:name)] }
end
