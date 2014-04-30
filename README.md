## Rails Clone

A minimal rails-clone to show how it all works to Lewagon's students.

### Architecture of Rails Clone

```
rails-clone/
  commands/
    generator
    server
  server/
    config.ru
    server.rb
  generator/
  activerecord/
  actioncontroller/
  actionview/
```

### Architecture of a Rails Clone app

```
clone-app/
  lib/
    rails-clone/
      [...]
  script/
    rails [generate|server]
  config/
  db/
    migrate/
  app/
    controllers/
    views/
    models/
```

### Rack

Rack provides a minimal API, to develop web applications in Ruby, for connecting web servers supporting Ruby (like WEBrick, Mongrel etc.) and Ruby web frameworks.

Most Web frameworks are actually built on top of Rack.

![Rack schema](http://rubylearning.com/images/rack.jpeg)

Rack allows you to easily deal with HTTP requests.

##### Rack application

A rack app consists of :

- An object with a `call` method (that includes : your own classes, ruby procs and lambdas...)
- This `call` method takes an `environment` Hash as argument.
- This `env` Hash is provided by Rack so you don't have to worry about it.
- The `call` method **must** return an `Array` of three values : `[status_code, headers, body]`
  - The status code is what determines if a request has been successful or not (for instance 200 for success, 404 or 500 for failures) [List of HTTP status codes](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
  - The headers determines the type of data that is sent back to the browser from your Rack application. It is stored in a `Hash` which usually would look like : { 'Content-Type' => 'text/html', 'Content-Length' => '35' }
  - The body is the HTML or the Text you want to display on your page.

Let's write two simple rack apps :

```
# myrackclass.rb

require 'rack'

class MyRackApp
  def call(env)
    [
      200,
      { 'Content-type' => 'text/html' },
      [
        '<html>' +
          env['PATH_INFO'] +
        '</html>'
      ]
    ]
  end
end

run MyRackApp.new
```

```
# myrackproc.rb

require 'rack'

my_rack_app = ->{ |env| [
                          200,
                          { "Content-Type" => "text/html" },
                          [ "<html> #{Time.now} </html>" ]
                        ]
                }

run my_rack_app
```

You can run any rack app using the `rackup` command.

```bash
$ rackup myrackclass.rb
```

```bash
$ rackup myrackproc.rb
```

Those two commands will start the default `WEBRick` server provided with Ruby.

If you'd like to change the server or port your rack applications are using, you must change the `run MyRackApp.new` part of your code with a more specific set of instructions :

```
# For a custom class
Rack::Server.start(app: MyRackApp.new, server: 'thin', Port: 9876)

# For a proc
Rack::Server.start(app: my_rack_app, server: 'thin', Port: 9876)
```

###### So, where does our rails clone comes into action ?

Well in our Rack application, our rails clone will provide us with the status code and the content.

```
class MyRackApp
  def call(env)
    # RailsClone::ProcessRequestAndShit.new

    [
      # Status we got from our Request processing,
      { 'Content-type' => 'text/html' },
      [
        # Data we got from our Request processing
      ]
    ]
  end
end
```