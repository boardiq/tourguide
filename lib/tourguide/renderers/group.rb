module Tourguide
  module Renderers
    class Group

      attr_reader :stops, :options

      def initialize(context, options={})
        @context = context
        @options = options.reverse_merge default_options
        @stops   = []
      end

      def render
        stops.each_with_index.map do |renderer, i|
          renderer.count = i
          renderer.total = total_stops
          renderer.render
        end.join("\n")
      end

       def stop(options={}, &block)
        renderer = Tourguide::Renderers::Stop.new(@context, options)
        yield(renderer) if block_given?
        stops << renderer
      end

      def total_stops
        @stops.count
      end

      private

        def default_options
          {}
        end

    end
  end
end