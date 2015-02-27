module Tourguide
  module Renderers
    class Connections

      attr_reader :options

      def initialize(context, options={})
        @context = context
        @options = options.reverse_merge default_options
        @connections = []
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.nav nav_options do |nav|
          nav << connections.map{ |x| x.render }.join("\n")
        end
        out.html_safe
      end

      def add(label, type)
        @connections << Tourguide::Renderers::Link.new(@context, label, type)
      end

      def connections
        @connections.any? ? @connections : default_connections
      end

      private

        def nav_options
          options.merge({class: css_classes})
        end

        def css_classes
          out = []
          out << ("connections-#{connections.count}")
          out << options[:class]
          out.compact.join(' ')
        end

        def default_options
          {}
        end

        def default_connections
          @default_connections ||= [
            Tourguide::Renderers::Link.new(@context, 'Previous', :prev),
            Tourguide::Renderers::Link.new(@context, 'Continue', :next)
          ]
        end

    end
  end
end