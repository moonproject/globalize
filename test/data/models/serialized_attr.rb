class SerializedAttr < ActiveRecord::Base
  serialize :meta
  translates :meta
end

class ArraySerializedAttr < ActiveRecord::Base
  self.table_name = 'serialized_attrs'
  if ::ActiveRecord.version >= Gem::Version.new("7.1.0")
    serialize :meta, type: Array
  else
    serialize :meta, Array
  end
  translates :meta
end

class JSONSerializedAttr < ActiveRecord::Base
  self.table_name = 'serialized_attrs'
  # if ::ActiveRecord.version >= Gem::Version.new("7.1.0")
    # serialize :meta, type: JSON
  # else
    serialize :meta, JSON
  # end
  translates :meta
end

class UnserializedAttr < ActiveRecord::Base
  self.table_name = 'serialized_attrs'
end
