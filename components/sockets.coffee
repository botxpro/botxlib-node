global.WebSocket = require 'universal-websocket-client'
Centrifuge = require 'centrifuge'
Botx = require '../Botx.coffee'
{ MD5 } = require 'object-hash'

Botx::initSockets = ->
  if @options.redis && !@options.user
    redis = require 'async-redis'
    @redis = redis.createClient @options.redis

  @connected = false
  @socketUrl = @options.socketUrl || "https://centrifugo.botx.pro/connection/websocket"
  try
    await @connect()
    @centrifuge
    @addSocketHandlers()
  catch e
    console.log 'can\'t connect to botx', e

Botx::addSocketHandlers = ->
  @centrifuge.subscribe "transaction##{@token.user}", (message) =>
    @handler message.data

  @centrifuge.on 'connect', (data) =>
    @connected = true
    console.log 'CONNECTED TO BOTX'

  @centrifuge.on 'disconnect', (err) =>
    @connected = false
    console.log 'DISCONNECTED FROM BOTX; REASON:', err.reason


Botx::getNotificationHash = (notification) ->
  MD5 JSON.stringify notification

Botx::checkNotificationExist = (notification) ->
  hash = @getNotificationHash notification
  res = await @redis.setnx "botxlib.notifications.#{hash}", hash
  res == 0

Botx::getSocketToken = ->
  @request 'tokens', uid: if @options.user then @options.user.steamId

Botx::connect = ->
  @token = data = await @getSocketToken()
  @centrifuge = new Centrifuge
    url: @socketUrl
    user: data.user
    timestamp: data.timestamp + ''
    token: data.token
  @centrifuge.connect()

