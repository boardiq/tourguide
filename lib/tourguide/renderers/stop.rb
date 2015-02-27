module Tourguide
  module Renderers
    class Stop

      attr_reader :options

      def initialize(context, options={})
        @context = context
        @options = options.reverse_merge(default_options[:tour]).reverse_merge(default_options.except(:tour))
      end

      def content &block
        raise ArgumentError unless block_given?
        @content = @context.capture(&block)
      end

      def connections(options={}, &block)
        @connections ||= begin 
          renderer = Tourguide::Renderers::Connections.new(@context, options)
          yield(renderer) if block_given?
          renderer
        end
      end

      def close
        @close ||= Tourguide::Renderers::Link.new(@context, options[:close][:label], :stop, options[:close])
      end

      def render
        @context.content_tag(:li, [close.render, @content, connections.render].join("\n").html_safe, li_options).html_safe
      end

      private

        def li_options
          {
            data: data_options
          }.merge(options[:wrapper])
        end

        def data_options
          options.except(:wrapper, :close).reject { |k, v| v.blank? }
        end

        def default_options
          {
            wrapper: {},
            tour: {
              el: nil,
              class: nil,
              orientation: 'centered',
              algin: 'left',
              width: nil,
              margin: nil,
              top: nil,
              left: nil,
              arrow: nil,
              zindex: nil,
            },
            close: {
              label: "&times;"
            }
          }
        end

    end
  end
end