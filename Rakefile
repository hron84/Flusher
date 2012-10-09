# -*- mode:ruby; indent-tabs-mode:nil; coding:utf-8 -*-
# vim:ts=2:sw=2:expandtab:
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'pathname'
require 'fileutils'

# Application own Settings
APPNAME               = "Flusher"
TARGET                = "#{APPNAME}.app"
#APPVERSION           = "rev#{`svn info`[/Revision: (\d+)/, 1]}"
#APPVERSION            = Time.now.strftime("%Y-%m-%d")
APPVERSION            = "1.0-dev-#{%x{git rev-parse HEAD}.strip[0..8]}"
PUBLISH               = 'yourname@yourhost:path'
DEFAULT_TARGET        = APPNAME
DEFAULT_CONFIGURATION = 'Release'
RELEASE_CONFIGURATION = 'Release'

# Tasks
task :default => [:run]

desc "Build the default and run it."
task :run => [:build] do
  sh %{open "build/Release/#{APPNAME}.app"}
end

desc 'Build the default target using the default configuration'
task :build => "xcode:build:#{DEFAULT_TARGET}:#{DEFAULT_CONFIGURATION}"

desc 'Deep clean of everything'
task :clean do
  puts %x{ xcodebuild -alltargets clean }
  FileUtils.rm_rf(['pkg', 'image', 'build'])
end

desc "Package the application"
task :package => ["xcode:build:#{DEFAULT_TARGET}:#{RELEASE_CONFIGURATION}", "pkg"] do
  name = "#{APPNAME}.#{APPVERSION}"
  FileUtils.mkdir_p('image')

  #sh %{cp -r "build/#{DEFAULT_CONFIGURATION}/#{APPNAME}.app" "image/#{APPNAME}.app"}
  FileUtils.cp_r("build/#{DEFAULT_CONFIGURATION}/#{APPNAME}.app", "image/#{APPNAME}.app")
  puts 'Creating Image...'
  sh %{
  hdiutil create -volname '#{name}' -srcfolder image '#{name}'.dmg
  rm -rf image
  mv '#{name}.dmg' pkg
  }
end

directory 'pkg'

# [Rubycocoa-devel 906] dynamically xcode rake tasks
# [Rubycocoa-devel 907]
#
def xcode_targets
  out = %x{ xcodebuild -list }
  out.scan(/.*Targets:\s+(.*)Build Configurations:.*/m)

  targets = []
  $1.each_line do |l|
    l = l.strip.sub(' (Active)', '')
    targets << l unless l.nil? or l.empty?
  end
  targets
end

def xcode_configurations
  out = %x{ xcodebuild -list }
  out.scan(/.*Build Configurations:\s+(.*)If no build configuration.*/m)

  configurations = []
  $1.each_line do |l|
    l = l.strip.sub(' (Active)', '')
    configurations << l unless l.nil? or l.empty?
  end
  configurations
end

namespace :xcode do
 targets = xcode_targets
 configs = xcode_configurations

 %w{build clean}.each do |action|
   namespace "#{action}" do

     targets.each do |target|
       desc "#{action} #{target}"
       task "#{target}" do |t|
         puts %x{ xcodebuild -target '#{target}' #{action} }
       end

       # alias the task above using a massaged name
       massaged_target = target.downcase.gsub(/[\s*|\-]/, '_')
       task "#{massaged_target}" => "xcode:#{action}:#{target}"


       namespace "#{target}" do
         configs.each do |config|
           desc "#{action} #{target} #{config}"
           task "#{config}" do |t|
             puts %x{ xcodebuild -target '#{target}' -configuration '#{config}' #{action} }
           end
         end
       end

       # namespace+task aliases of the above using massaged names
       namespace "#{massaged_target}" do
         configs.each { |conf| task "#{conf.downcase.gsub(/[\s*|\-]/, '_')}" => "xcode:#{action}:#{target}:#{conf}" }
       end

     end

   end
 end
end
