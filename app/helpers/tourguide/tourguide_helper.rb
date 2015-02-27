module Tourguide
  module TourguideHelper

    def tourbus id, options={}, &block
      renderer = Tourguide::Renderers::Tourbus.new(self, id, options)
      yield(renderer)
      renderer.render
    end

  end
end