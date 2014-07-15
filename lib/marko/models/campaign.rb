class Marko::Client::Campaign < Marko::Model
  identity :id

  attribute :name,             aliases: "name"
  attribute :description,      aliases: "description"
  attribute :program_name,     aliases: "programName"
  attribute :created_at,       aliases: "createdAt",     type: :datetime
  attribute :update_at,        aliases: "updatedAt",     type: :datetime

end
