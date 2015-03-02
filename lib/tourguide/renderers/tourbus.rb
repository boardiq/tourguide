module Tourguide
  module Renderers
    class Tourbus

      attr_reader :id, :options, :stops

      def initialize(context, id, options={})
        @context = context
        @id = id
        @options = options.reverse_merge(default_options)
        @stops = []
      end

      def stop(options={}, &block)
        renderer = Tourguide::Renderers::Stop.new(@context, options)
        yield(renderer) if block_given?
        stops << renderer
      end

      def group(options={}, &block)
        renderer = Tourguide::Renderers::Group.new(@context, options)
        yield(renderer) if block_given?
        stops << renderer
      end


      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.ul(ul_options) do |ul|
          ul << stops.map { |x| x.render }.join("\n")
        end
        xhtml.div class: 'tour-overlay'
        out.html_safe
      end

      private

        def ul_options
          {
            id: id,
            class: css_classes
          }.merge(options.except(:class))
        end

        def css_classes
          out = []
          out << 'tourbus-legs'
          out << options[:class]
          out.compact.join(' ')
        end

        def default_options
          {}
        end
        
    end
  end
end