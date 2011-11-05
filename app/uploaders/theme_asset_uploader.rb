# encoding: utf-8
class ThemeAssetUploader < CarrierWave::Uploader::Base
  include LiquidifySpree::CarierwaveExt
  
  def store_dir
    self.build_store_dir('themes', model.liquid_theme_id, model.folder)
  end
  
  def extension_white_list
    %w(jpg jpeg gif png css js swf flv eot svg ttf woff otf ico htc)
  end
  
  def build_store_dir(*args)
    default_dir = self.class.store_dir

    if default_dir.blank? || default_dir == 'uploads'
      File.join(args.map(&:to_s))
    else
      File.join([default_dir] + args.map(&:to_s))
    end
  end
  
  def self.url_for(theme, path)
    build(theme, path)
  end
  
  def self.build(theme, path)
    asset = ThemeAsset.new(:liquid_theme => theme, :folder => File.dirname(path))
    uploader = ThemeAssetUploader.new(asset)
    uploader.retrieve_from_store!(File.basename(path))
    uploader
  end
  
end