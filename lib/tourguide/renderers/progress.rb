module Tourguide
  module Renderers
    class Progress

      def initialize(context, count, total)
        @context = context
        @count   = count
        @total   = total
      end

      def render
        return "" if uncountable?
        (0...@total).map do |i|
          css = ['bullet']
          css << 'active' if i == @count
          @context.content_tag(:li, "&bull;".html_safe, class: css.join(' '))
        end.join("\n").html_safe
      end

      def uncountable?
        @count.blank? && @total.blank?
      end

    end
  end
end