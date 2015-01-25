require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    # disable paperclip content type spoofing
    def spoofed?
      false
    end
  end
end