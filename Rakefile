# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'
require 'sugarcube-gestures'
require 'motion-cocoapods'
require 'bundler'

if ARGV.join(' ') =~ /spec/
  Bundler.require :default, :spec
else
  Bundler.require
end

# documents_path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
# NanoStore.shared_store = NanoStore.store(:file, "./nano.db")

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'survey_app'
  app.identifier = 'com.multunus.surveyapp'
  app.icons = ['Icon-Small-50.png', 'Icon-Small@2x.png', 'iTunesArtwork.png', 'Icon-72.png', 'Icon-Small-50@2x.png', 'Icon.png', 'iTunesArtwork@2x.png', 'Icon-72@2x.png', 'Icon-Small.png', 'Icon@2x.png']
  app.device_family = :iphone
  app.interface_orientations = [:portrait]

  #cocoa pods
  app.pods do
    pod 'NanoStore', '~> 2.6.4'
  end
  
  #testflight config
  app.testflight.sdk = "vendor/TestFlight"
  app.testflight.api_token = "93711422c972050001139aed3092685c_OTM2ODY0MjAxMy0wMy0xNyAyMzowNzo0MS43OTk0NDc"
  app.testflight.team_token = "37a3b6123d28a01e59d2fe9b071760ec_MjM3MjI4MjAxMy0wNi0xNyAwMDozNTo0MC44ODAyODI"
  
end
