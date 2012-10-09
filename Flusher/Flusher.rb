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

include OSX
OSX.require_framework 'ScriptingBridge' # TODO remove me

class Flusher < NSObject
  @menu = nil
  @status_item = nil
  @icon = nil

  def initialize
     @menu = NSMenu.alloc.init

  end

  def applicationDidFinishLaunching(aNotification)

    statusbar = NSStatusBar.systemStatusBar
    @status_item = statusbar.statusItemWithLength(NSVariableStatusItemLength)

    menu_item = @menu.addItemWithTitle_action_keyEquivalent("Flush DNS cache", "flushCache:", '')

    menu_item = @menu.addItemWithTitle_action_keyEquivalent("Quit", "terminate:", '')
    menu_item.setKeyEquivalentModifierMask(NSCommandKeyMask)
    menu_item.setTarget(NSApp)

    text = NSString.alloc.initWithString("DNS Flush")
    @status_item.setTitle(text)

    @icon = NSImage.imageNamed_('globe.png')
    #@icon = NSImage.alloc.initWithContentsOfFile 'globe.png'
    @status_item.setImage(@icon)

    @status_item.setMenu(@menu)

  end

  def applicationWillTerminate(aNotification)
    puts "Good bye!"
  end

  def flushCache(sender)
    case osx_version.first
    when 10.7..10.8
      command = 'sudo killall -HUP mDNSResponder'
    when 10.5..10.6
      command = 'dscacheutil -flushcache'
    else
      command = 'lookupd -flushcache'
    end
    
    system(command)
    puts "Cache flushed via #{command}"
  end
  
  private

  def osx_version
    verstr = NSProcessInfo.processInfo.operatingSystemVersionString.to_s
    ret = verstr.scan(/^Version (\d+\.\d+)(\.\d+)?/).flatten
    ret[1].sub!('.', '')
    ret[0] = ret[0].to_f
    return ret
  end
end

NSApplication.sharedApplication
NSApp.setDelegate(Flusher.alloc.init)
NSApp.run
