class Hash
  class << self
    def from_xml(xml)
      typecast_xml_value(unrename_keys(remove_pagination_attributes(::ActiveSupport::XmlMini.parse(xml))))
    end

    def remove_pagination_attributes(deserialized_xml)
      if deserialized_xml.values.size == 1 && deserialized_xml.values.first['type'] == 'array'
        clone = deserialized_xml.clone
        clone.values.first.delete 'per_page'
        clone.values.first.delete 'current_page'
        clone.values.first.delete 'total_entries'
        return clone
      end
      deserialized_xml
    end
  end
end
