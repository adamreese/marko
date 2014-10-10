class Marko::Client::LeadChange < Marko::Model
  identity :id

  attribute :lead_id,             aliases: "leadId",         type: :integer
  attribute :activity_date,       aliases: "activityDate",   type: :datetime
  attribute :activity_type_id,    aliases: "activityTypeId", type: :integer
  attribute :fields,              aliases: "fields",         type: :array
  attribute :activity_attributes, aliases: "attrs",          type: :array

end
