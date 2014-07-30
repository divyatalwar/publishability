class ElementType < ActiveRecord::Base
  include Publishable
  belongs_to :element, polymorphic: true

  belongs_to :module, foreign_key: 'module_id', class_name: 'EmbeddedModule'

  after_save :validate_publishing_chain

  
  def check_publishing_rules
  end

end