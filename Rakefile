# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RedditMotion'
  app.short_version = "0.1"
  app.version = "0.1"

  app.vendor_project('vendor/ViewDeck', :static)

  app.pods do
    pod 'AFNetworking'
  end
end
