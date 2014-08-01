class Section < ActiveRecord::Base
  include Publishable
  belongs_to :page
  has_many :modules, class_name: 'EmbeddedModule',  dependent: :destroy

  

  def check_publishing_rules
    publishing_errors.add(:name, 'must not be blank') if name.blank?
    publishing_errors.add(:page_id, 'must exist') unless page
    publishing_errors.add(:base, "Must have at least one modules") if modules.length.zero?
    publishing_errors.add(:base, "One or more modules are unpublishable") unless modules.all?(&:publishable?)
  end
  
  def notify_publishability_upchain!
    page.notify_publishability_change! if page
  end
end

