class Page < ActiveRecord::Base
  include Publishable
  belongs_to :site
  has_many :sections, dependent: :destroy
  after_save :validate_publishing_chain


  def check_publishing_rules_without_sections
    publishing_errors.add(:name, 'must not be blank') if name.blank?
    publishing_errors.add(:page_title, 'must not be blank') if page_title.blank?
    publishing_errors.add(:keywords, 'must not be blank') if keywords.blank?
    publishing_errors.add(:description, 'must not be blank') if description.blank?
  end



  def check_publishing_rules
    check_publishing_rules_without_sections
    publishing_errors.add(:site_id, 'must exist')  unless site
    publishing_errors.add(:base, "Must have at least one section") if sections.length.zero?
    publishing_errors.add(:base, "One or more sections are unpublishable") unless sections.all?(&:publishable_without_caching?)
  end

  def notify_publishability_upchain!
    site.notify_publishability_change! if site
  end
end