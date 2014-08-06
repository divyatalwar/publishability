  module Publishable
    extend ActiveSupport::Concern
    
    def notify_publishability_change!
      #This line writes the status of the publishability on the calling instance so that the instance remains in the consistent state whenever reffered 
      write_attribute(:publishable_flag, publishable?)
      #This makes the changes listed above at the backend
      ActiveRecord::Base.connection.execute("update #{self.class.table_name} set publishable_flag = #{publishable_flag} where id = #{id}")
      # This calls the current method on its immediate parent to check for publishability
      notify_publishability_upchain! if respond_to?(:notify_publishability_upchain!)
    end
    
    def publishing_errors
      @publishing_errors ||= ActiveModel::Errors.new(self)
    end

    def publishable?
      check_publishability.empty?
    end

    def check_publishability
      publishing_errors.clear
      check_publishing_rules
      publishing_errors
    end

    def check_publishing_rules
      raise Exception.new("check_publishing_rules needs to be redefined by including class: #{self.class}")
    end


    def validate_publishability
      notify_publishability_change!
    end

  end
