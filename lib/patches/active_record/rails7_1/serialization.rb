module Globalize
  module AttributeMethods
    module Serialization
      def serialize(attr_name, class_name_or_coder = Object, **options)
        if class_name_or_coder == ::JSON || [:load, :dump].all? { |x| class_name_or_coder.respond_to?(x) }
          options = options.merge(coder: class_name_or_coder, type: Object)
        else
          options = options.merge(type: class_name_or_coder)
        end

        super(attr_name, **options)

        coder = if options[:coder] == ::JSON
                  ::ActiveRecord::Coders::JSON
                elsif options.key?(:coder)
                  options[:coder]
                else
                  ::ActiveRecord::Coders::YAMLColumn.new(attr_name, options[:type], **(options.fetch(:yaml, {})))
                end

        self.globalize_serialized_attributes = globalize_serialized_attributes.dup
        self.globalize_serialized_attributes[attr_name] = coder
      end
    end
  end
end

ActiveRecord::AttributeMethods::Serialization::ClassMethods.send(:prepend, Globalize::AttributeMethods::Serialization)