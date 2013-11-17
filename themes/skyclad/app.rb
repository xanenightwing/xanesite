# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    use Rack::Static, :urls => ["/skyclad"], :root => "themes/skyclad/public"

    helpers do
      # True if any items in this menu prefix the currently active item
      def unfold_menu?(menu_items)
        #@active_item ||= nil
        #return false if @active_item.nil?
        #menu_items.any? { |i| @active_item.abspath.start_with?(i.abspath) }
        true
      end

      # Returns the active menu from a given set of items
      def active_menu_item(menu_items)
        @active_item ||= nil
        menu_items.each do |item|
          if item.respond_to?(:each)
            active_menu_item(item)
          else
            @active_item = item if request.path.start_with?(item.abspath)
          end
        end
      end
    end
  end
end
