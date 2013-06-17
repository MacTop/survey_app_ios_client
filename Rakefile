# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'
require 'sugarcube-gestures'
require 'bundler'

if ARGV.join(' ') =~ /spec/
  Bundler.require :default, :spec
else
  Bundler.require
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'survey_app'
  app.identifier = 'com.multunus.surveyapp'

  app.device_family = :iphone
  app.interface_orientations = [:portrait]
  
  #testflight config
  app.testflight.sdk = "vendor/TestFlight"
  app.testflight.api_token = "93711422c972050001139aed3092685c_OTM2ODY0MjAxMy0wMy0xNyAyMzowNzo0MS43OTk0NDc"
  app.testflight.team_token = "37a3b6123d28a01e59d2fe9b071760ec_MjM3MjI4MjAxMy0wNi0xNyAwMDozNTo0MC44ODAyODI"
  
end
