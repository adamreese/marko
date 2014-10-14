class Marko::Client::LeadChange < Marko::Model
  identity :id

  attribute :lead_id,             aliases: "leadId",         type: :integer
  attribute :activity_date,       aliases: "activityDate",   type: :datetime
  attribute :activity_type_id,    aliases: "activityTypeId", type: :integer
  attribute :fields,              aliases: "fields",         parser: lambda { |v,_| v.first }
  attribute :activity_attributes, aliases: "attributes",     parser: lambda { |v,_| Hash[v.map(&:values)] }

end
