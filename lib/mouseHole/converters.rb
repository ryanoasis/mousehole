# Module containing possible mime type convertors (in order to be rewriteable content, a
# convertor class must identify itself as able to handle a mime type.)
module MouseHole
module Converters

  def self.detect_by_mime_type type_str
    self.constants.map { |c| const_get(c) }.detect do |c|
      if c.respond_to? :handles_mime_type?
        c.handles_mime_type? type_str
      end
    end
  end

  class Base
    def self.mime_type type_match
      if type_match.index('*')
        type_match = /^#{Regexp::quote(type_match).gsub(/\\\*/, '.*')}$/
      end
      @mime_types ||= []
      @mime_types << type_match
    end
    def self.handles_mime_type? type_str
      (@mime_types || []).any? { |mt| mt === type_str }
    end
  end

end
end
