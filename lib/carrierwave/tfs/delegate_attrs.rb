module CarrierWave
  module TFS
    module DelegateAttrs
      extend ::ActiveSupport::Concern
    
      module ClassMethods
        def store_file_name_delegate_attr(attribute, default = nil)
          # attr_accessor attribute

          # before :remove, :"reset_#{attribute}"

          var_name = :"@#{attribute}"

          # define_method :"#{attribute}" do
          #   model_accessor = store_file_name_getter_name(attribute)
          #   value = instance_variable_get(var_name)
          #   value ||= self.model.send(model_accessor) if self.model.present? && self.model.respond_to?(model_accessor)
          #   value ||= default
          #   instance_variable_set(var_name, value)
          # end

          define_method :"#{attribute}=" do |value|
            model_accessor = store_file_name_getter_name(attribute)     
            puts "--- #{self.model.send(:id)}"    
            self.model.send(:"#{model_accessor}=", value) 
            # instance_variable_set(model_accessor, value)
          end

          define_method :"reset_#{attribute}" do
            self.send(:"#{attribute}=", default)
            send(:"#{attribute}=", default)
          end
        end
      end
    
      private
      def store_file_name_getter_name(attribute)
        name = []
        name << mounted_as if mounted_as.present?
        name << version_name if version_name.present?
        name << attribute
        name.join('_')
      end
    end
  end
end
