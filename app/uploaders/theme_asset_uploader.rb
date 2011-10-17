# encoding: utf-8
class ThemeAssetUploader < CarrierWave::Uploader::Base
  def store_dir
    self.build_store_dir('themes', model.liquid_theme_id, model.folder)
  end
  
  def extension_white_list
    %w(jpg jpeg gif png css js swf flv eot svg ttf woff otf ico htc)
  end
  
  
end