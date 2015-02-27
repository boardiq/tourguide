module Tourguide
  class Engine < ::Rails::Engine

    config.to_prepare do
      ApplicationController.helper Tourguide::TourguideHelper
    end

  end
end