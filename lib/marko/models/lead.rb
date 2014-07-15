class Marko::Client::Lead < Marko::Model
  identity :id

  attribute :email,         aliases: "email"
  attribute :first_name,    aliases: "firstName"
  attribute :last_name,     aliases: "lastName"
  attribute :created_at,    aliases: "createdAt",   type: :datetime
  attribute :update_at,     aliases: "updatedAt",   type: :datetime

  def save
    response = if new_record?
                 self.connection.create_lead(marketo_parameters)
               else
                 self.connection.update_lead(marketo_parameters)
               end
    merge_attributes(response.body["result"].first)
  end

  def update(params={})
    requires :identity

    self.connection.update_lead(self.identity, marketo_parameters(params))
    merge_attributes(self.connection.get_lead(self.identity).body["result"].first)
  end
end
