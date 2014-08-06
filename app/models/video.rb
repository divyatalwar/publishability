class Video <  ActiveRecord::Base
  include Publishable
  has_one :element_type, as: :element
  has_one :module, through: :element_type

  def check_publishing_rules
    publishing_errors.add(:url, 'must not be blank')  if url.blank?
  end

  def notify_publishability_upchain!
    self.module.notify_publishability_change! if self.module
  end
  
end