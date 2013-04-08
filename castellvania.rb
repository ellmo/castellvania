# Require gems
require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'pry'

# Require media loader
require File.join(File.dirname(__FILE__), 'loader')

# Require the roots for all entities
require "./classes/base/entity.rb"
require "./classes/base/brush.rb"

# Since all neccessary classes have been required already,
# we can safely require ALL the other stuff.
Dir["./classes/**/*.rb"].each {|file| require file}

window = GameWindow.new
window.show