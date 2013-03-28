require "compass"
require "sinatra/base"
require "sinatra/advanced_routes"

module Sinatra
  module Compass

    module ClassMethods
      attr_reader :compass_route, :compass_prefix
      def get_compass(path, &block)
        path.sub! /^\//, ''
        block ||= Proc.new do |file|
          content_type 'text/css', :charset => 'utf-8'
          compass :"#{path}/#{params[:name]}"
        end
        set :compass, :sass_dir => views / path unless compass[:sass_dir] && compass[:sass_dir].directory?
        @compass_prefix = "/#{path}"
        @compass_route.deactivate if @compass_route
        @compass_route = get("/#{path}" / ":name.css", &block)
      end
    end

    module InstanceMethods
      def compass(file, options = {})
        options.merge! ::Compass.sass_engine_options
        sass file, options
      end

      def stylesheet(name)
        settings.compass_prefix / "#{name}.css"
      end
    end

    def self.registered(klass)
      klass.register Sugar
      klass.register AdvancedRoutes
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
      klass.set :compass, :projet_path => File.expand_path(klass.root) if klass.root
      klass.set :compass, :sass_dir => klass.views / "stylesheets" if klass.views
      klass.set :compass, :output_style => (klass.development? ? :expanded : :compressed)
      klass.set :compass, :line_comments => klass.development?
      set_app_file(klass) if klass.app_file?
    end

    def self.set_app_file(klass)
      klass.set :compass, :root_path => klass.root_path
      klass.get_compass("stylesheets") if (klass.views / "stylesheets").directory?
    end

    def self.set_compass(klass)
      ::Compass.configuration do |config|
        config.sass_options ||= {}
        klass.compass.each do |option, value|
          if config.respond_to? option
            config.send "#{option}=", value
          else
            config.sass_options.merge! option.to_sym => value
          end
        end
      end
    end

  end

  register Compass

end
