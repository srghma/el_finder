require 'rubygems'
require 'shellwords'
require 'fastimage'

module ElFinder

  # Represents default image handler.
  # It uses *mogrify* to resize images and *convert* to create thumbnails.
  class Image

    def self.size(pathname)
      return nil unless File.exist?(pathname)
      begin
        size = ::FastImage.size(pathname)
        return "#{size[0]}x#{size[1]}" if size
      rescue
        nil
      end
    end

    def self.resize(pathname, options = {})
      return nil unless File.exist?(pathname)
      system( ::Shellwords.join(['mogrify', '-resize', "#{options[:width]}x#{options[:height]}!", pathname.to_s]) )
    end # of self.resize

    def self.thumbnail(src, dst, options = {})
      return nil unless File.exist?(src)
      src = "#{src.to_s}[0]" if options[:has_frames]
      system( ::Shellwords.join(['convert', '-resize', "#{options[:width]}x#{options[:height]}", '-background', 'white', '-gravity', 'center', '-extent', "#{options[:width]}x#{options[:height]}", src.to_s, dst.to_s]) )
    end # of self.resize

  end # of class Image

end # of module ElFinder
