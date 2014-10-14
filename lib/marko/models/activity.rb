class Marko::Client::Activity < Marko::Model
  identity :id

  attribute :lead_id,                    aliases: "leadId",                  type: :integer
  attribute :activity_date,              aliases: "activityDate",            type: :datetime
  attribute :activity_type_id,           aliases: "activityTypeId",          type: :integer
  attribute :primary_attribute_value_id, aliases: "primaryAttributeValueId", type: :integer
  attribute :primary_attribute_value,    aliases: "primaryAttributeValue",   type: :string
  attribute :activity_attributes,        aliases: "attributes",              parser: lambda { |v,_| Hash[v.map(&:values)] }
end
