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
end