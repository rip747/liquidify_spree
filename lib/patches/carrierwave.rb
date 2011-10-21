#require 'carrierwave'

module CarrierWave
  class SanitizedFile
    # FIXME add *to_s* before *chomp* method. Is this a fix for bug:
    # NoMethodError: undefined method `chomp' for application/javascript:MIME::Type
    def content_type
      return @content_type if @content_type
      @file.content_type.to_s.chomp if @file.respond_to?(:content_type) and @file.content_type
    end
  end
end