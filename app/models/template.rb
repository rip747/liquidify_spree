class Template < ActiveRecord::Base
  include Extensions::SerializedTemplate
  belongs_to :theme
end
