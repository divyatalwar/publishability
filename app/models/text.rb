class Text <  ActiveRecord::Base
  include Publishable
  has_one :element_type, as: :element
  has_one :module, through: :element_type



  def validate_publishability
    publishing_errors.add(:content, 'must not be blank')  if content.blank?
  end

  def notify_publishability_upchain!
    self.module.notify_publishability_change! if self.module
  end
end