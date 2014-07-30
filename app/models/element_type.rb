class ElementType < ActiveRecord::Base
  include Publishable
  belongs_to :element, polymorphic: true

  belongs_to :module, foreign_key: 'module_id', class_name: 'EmbeddedModule'

  
  
  
end