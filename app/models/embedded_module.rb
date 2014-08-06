class EmbeddedModule < ActiveRecord::Base
  self.table_name ='modules'
  include Publishable
  
  belongs_to :section
  has_many :element_types, foreign_key: :module_id
  has_many :text_elements, through: :element_types, source: :element, source_type: 'Text'
  has_many :video_elements, through: :element_types, source: :element, source_type: 'Video'
  has_many :image_elements, through: :element_types, source: :element, source_type: 'Image'
  has_many :audio_elements, through: :element_types, source: :element, source_type: 'Audio'


  def check_publishing_rules
    publishing_errors.add(:name, 'must not be blank') if name.blank?
    publishing_errors.add(:section_id, 'must exist')  unless section
    publishing_errors.add(:base, "Must have at least one element") if elements.length.zero?
    publishing_errors.add(:base, "One or more elements are unpublishable") unless elements.all?(&:publishable?)
  end

  def notify_publishability_upchain!
    section.notify_publishability_change! if section
  end

  def elements
    text_elements + audio_elements + video_elements + image_elements
  end

end