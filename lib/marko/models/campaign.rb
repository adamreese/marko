class Marko::Client::Campaign < Marko::Model
  identity :id

  attribute :name,          type: :string
  attribute :description,   type: :string
  attribute :program_name,  type: :string,   aliases: "programName"
  attribute :created_at,    type: :datetime, aliases: "createdAt"
  attribute :update_at,     type: :datetime, aliases: "updatedAt"

end
