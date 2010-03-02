Sinatra::Compass
================

Integrates the Compass stylesheet framework with [Sinatra](http://sinatrarb.com).

BigBand
-------

Sinatra::Compass is part of the [BigBand](http://github.com/rkh/big_band) stack.
Check it out if you are looking for other fancy Sinatra extensions.


Installation
------------

    gem install sinatra-compass --prerelease

Usage
-----

Usage without doing something:

    require "sinatra"
    require "sinatra/compass"

If you create a directory called views/stylesheets and place your
sass files in there, there you go. Just call stylesheet(name) form
your view to get the correct stylesheet tag. The URL for your
stylesheets will be /stylesheets/:name.css.

Of course you can use any other setup. Say, you want to store your
stylesheets in views/css and want the URL to be /css/:name.css:

    get_compass("css")

But what about more complex setups?

    require "sinatra/base"
    require "sinatra/compass"

    class Foo < Sinatra::Base
      register Sinatra::Compass
      set :compass, :sass_dir => "/foo/bar/blah"
      get_compass("/foo/:name.css") do
        compass :one_stylesheet
      end
    end

Note that already generated routes will be deactivated by calling
get_compass again.