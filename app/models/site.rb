class Site <  ActiveRecord::Base
  include Publishable
  has_many :pages, dependent: :destroy
 
  def check_publishing_rules
    publishing_errors.add(:name, 'must not be blank') if name.blank?
    publishing_errors.add(:base, 'no pages listed for this site') if pages.length.zero?
    publishing_errors.add(:base, 'one or more pages are unpublishable') unless pages.all?(&:publishable?)
  end

end