class Image <  ActiveRecord::Base
  has_one :element_type, as: :element
  has_one :module, through: :element_type

  def validate_publishability
    publishing_errors.add(:alt, 'must not be blank')  if alt.blank?
    publishing_errors.add(:url, 'must not be blank')  if url.blank?
  end

  def notify_publishability_upchain!
    self.module.notify_publishability_change! if self.module
  end
end