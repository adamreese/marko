class Marko::Client::Lead < Marko::Model
  identity :id

  attribute :email,         type: :string
  attribute :first_name,    type: :string,   aliases: "firstName"
  attribute :last_name,     type: :string,   aliases: "lastName"
  attribute :created_at,    type: :datetime, aliases: "createdAt"
  attribute :update_at,     type: :datetime, aliases: "updatedAt"

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
