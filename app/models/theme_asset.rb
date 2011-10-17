class ThemeAsset < ActiveRecord::Base
  include Extensions::AssetType
  belongs_to :liquid_theme
  
  attr_accessor :plain_text_name, :plain_text, :plain_text_type, :performing_plain_text
  
  mount_uploader :source, ThemeAssetUploader
  
  ## callbacks ##
  before_validation :store_plain_text
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
  
  def plain_text_name
    if not @plain_text_name_changed
      @plain_text_name ||= self.safe_source_filename
    end
    @plain_text_name.gsub(/(\.[a-z0-9A-Z]+)$/, '') rescue nil
  end
  
  def plain_text_name=(name)
    @plain_text_name_changed = true
    @plain_text_name = name
  end
  
  def plain_text
    if RUBY_VERSION =~ /1\.9/
      @plain_text ||= (self.source.read.force_encoding('UTF-8') rescue nil)
    else
      @plain_text ||= self.source.read
    end
  end
  
  def plain_text_type
    @plain_text_type || (stylesheet_or_javascript? ? self.content_type : nil)
  end

  def performing_plain_text?
    self.performing_plain_text || false
  end
  
  def store_plain_text
    self.content_type ||= @plain_text_type if self.performing_plain_text?

    data = self.performing_plain_text? ? self.plain_text : self.source.read

    return if !self.stylesheet_or_javascript? || self.plain_text_name.blank? || data.blank?

    sanitized_source = self.escape_shortcut_urls(data)

    self.source = CarrierWave::SanitizedFile.new({
      :tempfile => ::StringIO.new(sanitized_source),
      :filename => "#{self.plain_text_name}.#{self.stylesheet? ? 'css' : 'js'}"
    })
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
  
  def escape_shortcut_urls(text)
    return if text.blank?

    text.gsub(/[("'](\/(stylesheets|javascripts|images|medias)\/(([^;.]+)\/)*([a-z_\-0-9]+)\.[a-z]{2,3})[)"']/) do |path|

      sanitized_path = path.gsub(/[("')]/, '').gsub(/^\//, '')

      if asset = self.liquid_theme.theme_assets.where(:local_path => sanitized_path).first
        "#{path.first}#{asset.source.url}#{path.last}"
      else
        path
      end
    end
  end
  
  def content_type_can_not_changed
    self.errors.add(:source, :extname_changed) if !self.new_record? && self.content_type_changed?
  end
end