require 'java'

java_import 'io.javalin.Javalin'

Javalin.create()
  .get('/') { |ctx| ctx.result("hello jruby") }
  .start(7070)
