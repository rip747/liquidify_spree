class ThemeAsset < ActiveRecord::Base
  include Extensions::AssetType
  include Extensions::PlainStore
  belongs_to :liquid_theme
  
  mount_uploader :source, ThemeAssetUploader
  
  ## callbacks ##
  before_validation :sanitize_folder
  before_validation :build_local_path
    
  def stylesheet_or_javascript?
    self.stylesheet? || self.javascript?
  end
  
  def local_path(short = false)
    if short
      self.read_attribute(:local_path).gsub(/^#{self.content_type.to_s.pluralize}\//, '')
    else
      self.read_attribute(:local_path)
    end
  end
  
  def to_liquid
    { :url => self.source.url }.merge(self.attributes).stringify_keys
  end
  
  def safe_source_filename
    self.source_filename || self.source.send(:original_filename) rescue nil
  end
  
  def sanitize_folder
    self.folder = self.content_type.to_s.pluralize if self.folder.blank?

    # no accents, no spaces, no leading and ending trails
    self.folder = ActiveSupport::Inflector.transliterate(self.folder).gsub(/(\s)+/, '_').gsub(/^\//, '').gsub(/\/$/, '')

    # folder should begin by a root folder
    if (self.folder =~ /^(stylesheets|javascripts|images|medias|fonts)/).nil?
      self.folder = File.join(self.content_type.to_s.pluralize, self.folder)
    end
  end
  
  def build_local_path
    if filename = self.safe_source_filename
      self.local_path = File.join(self.folder, filename)
    else
      nil
    end
  end
  
  
  
  def content_type_can_not_changed
    self.errors.add(:source, :extname_changed) if !self.new_record? && self.content_type_changed?
  end
end