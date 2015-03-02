require 'sass-rails'
require 'coffee-rails'
require 'builder'

require "tourguide/version"
require "tourguide/engine" if defined? Rails

require "tourguide/renderers/tourbus"
require "tourguide/renderers/link"
require "tourguide/renderers/connections"
require "tourguide/renderers/group"
require "tourguide/renderers/progress"
require "tourguide/renderers/stop"

module Tourguide

end
