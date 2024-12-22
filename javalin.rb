require 'java'
require 'jwt'

java_import 'io.javalin.Javalin'
java_import 'org.slf4j.LoggerFactory'

require './app/controllers/users_controller'

logger = LoggerFactory.getLogger('javalin app')

hmac_secret = 'my$ecretK3y'

app = Javalin.create() do |config|
        config.useVirtualThreads = true
      end
    .start(7070)

logger.info('application started ...')

app.before("/api/*") do |ctx|
  logger.info('received request ...')
  
  auth_header = ctx.header('Authorization')
  raise StandardError.new 'No Authorization header found' if auth_header.nil?
  
  JWT.decode(auth_header.slice(7..(auth_header.size)), hmac_secret, true, { algorithm: 'HS256' })
end

app.get('/token/') do |ctx|
  ctx.json({ token: JWT.encode({ role: 'admin' }, hmac_secret, 'HS256') })
end

app.get('/api/users/') do |ctx|
  users = UsersController.new.find_all
  ctx.json({ users: users })
end
