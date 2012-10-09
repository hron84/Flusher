#
#  rb_main.rb
#  Flusher
#
#  Created by Gabor Garami on 2012.10.09..
#  Copyright (c) 2012 Gabor Garami. Some rights reserved.
#
#  This program is licensed under the terms of Creative Commons BY-NC-SA License
#  To details, see COPYING file in project root
#

require 'osx/cocoa'

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

rb_main_init
