  module Publishable
    
    def notify_publishability_change!(first_link = true)
      write_attribute(:publishable_flag, publishable?)
      ActiveRecord::Base.connection.execute("update #{self.class.table_name} set publishable_flag = #{publishable_flag} where id = #{id}")
      notify_publishability_upchain! if respond_to?(:notify_publishability_upchain!)
    end
    
    def publishing_errors
      @publishing_errors ||= ActiveModel::Errors.new(self)
    end

    def publishable?
      check_publishability().empty?
    end

    def check_publishability
      publishing_errors.clear
      check_publishing_rules
      publishing_errors
    end

    # included class can defined method notify_publishability_upchain!()
    # to define additional notification chain and must define method
    # check_publishing_rules() that add to publishing_errors
    def check_publishing_rules
      raise Exception.new("check_publishing_rules needs to be redefined by including class: #{self.class}")
    end


    def validate_publishability
      notify_publishability_change!(true)
    end

  end
# module Publishable

    
#     def notify_purchasability_change!(first_link = true)
#       write_attribute(:publishable_flag, publishable_without_caching?)
#       connection.execute("update #{self.class.table_name} set publishable_flag = #{publishable_flag} where id = #{id}")
#       notify_publishability_upchain! if respond_to?(:notify_publishability_upchain!)
#     end
    


#     def publishing_errors
#       @publishing_errors ||= ActiveModel::Errors.new(self)
#     end

#     def publishable_without_caching?
#       check_publishability().empty?
#     end

#     def check_publishability
#       publishing_errors.clear
#       check_publishing_rules
#       publishing_errors
#     end

#     def check_publishing_rules
#       raise Exception.new("check_publishing_rules needs to be redefined by including class: #{self.class}")
#     end

#     def enforce_publishing_validation!
#       @enforce_publishing_validation = true
#     end

#     def validate_publishing_chain
#       if @enforce_publishing_validation
#         notify_publishability_change!(true)
#       end
#     end

#   end