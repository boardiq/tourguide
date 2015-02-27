module Tourguide
  module Renderers
    class Link

      attr_reader :options, :label, :type

      def initialize(context, label, type, options={})
        @context = context
        @label   = label
        @type    = type
        @options = options.reverse_merge default_options
      end

      def render
        @context.link_to label.html_safe, options[:href], html_options
      end

      private

        def default_options
          {
            href:  'javascript:void(0);',
            class: nil
          }
        end

        def html_options
          options.except(:label, :href).merge({class: css_class})
        end

        def css_class
          out = [options[:class]]
          out << 'tour-link'
          out << "tourbus-#{type}"
          out.compact.join(' ')
        end

    end
  end
end