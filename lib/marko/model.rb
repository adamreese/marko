class Marko::Model < Cistern::Model
  def marketo_parameters(attrs = nil)
    (attrs || self.attributes).inject({}) do |r, (attr, value)|
      attribute_alias = (self.class.aliases.detect { |_, v| v.include?(attr) } || []).first

      r[attribute_alias || attr] = value
      r
    end
  end
end
