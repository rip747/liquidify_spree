module Admin::ThemeAssetsHelper
  def data_html_editor_type(asset)
    asset_type = asset.content_type || params[:content_type]
    case asset_type.to_sym
    when :stylesheet
      "CSS"
    when :javascript
      "JS"
    end
  end
end