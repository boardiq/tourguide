module Tourguide
  module Renderers
    class Stop

      attr_reader :options
      attr_writer :count, :total

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
        @context.content_tag(:li, rendered_content, li_options).html_safe
      end

      def progress
        @progress ||= Tourguide::Renderers::Progress.new(@context, @count, @total)
      end

      private

        def rendered_content
          [close.render, @content, progress_content, connections.render].compact.join("\n").html_safe
        end

        def progress_content
          @context.content_tag(:ol, progress.render, class: 'progress-list') unless progress.uncountable?
        end

        def li_options
          {
            data: data_options
          }.merge(options[:wrapper])
        end

        def data_options
          options.except(:wrapper, :close, :counter).reject { |k, v| v.blank? }
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