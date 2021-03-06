# @author    Gleb Vishnevsky (nfteam.ru/gleb.vishnevsky)
# @copyright Copyright (c) 2017 Gleb Vishnevsky
# @license   https://opensource.org/licenses/MIT The MIT License (MIT)
EventEmitter = require 'events'

axios = require 'axios'
sha256 = require 'sha256'
safeCompare = require 'safe-compare'
{toCamel, toSnake, errorToCamel} = require './helpers.coffee'

ENDPOINTS = require './enums/endpoints.coffee'
IpnCallback = require './IpnCallback.coffee'
Transaction = require './Transaction.coffee'

class Botx extends EventEmitter
  constructor: (@options = {}) ->
    super()
    @apiUrl = @options.apiUrl || 'https://api.botx.pro'
    @apiVersion = @options.apiVersion || 'v1'

    @projectId = @options.projectId
    @apiKey = @options.apiKey
    @projectType = @options.projectType

    do @initializers

    unless @projectId && @apiKey
      throw new Error 'projectId and apiKey required'

    unless ['market', 'individual'].includes @projectType
      throw new Error "#{@projectType} is not valid project type"

Botx::initializers = ->

Botx::loadItemSettings = (params = {}) ->
  unless params.compact
    params.compact = true

  if params.compact
    data = await @request 'loadItemSettingsCompact', params
    return data.prices

  @request 'loadItemSettings', params

Botx::getUrl = (endpoint) ->
  return "#{@apiUrl}/#{@apiVersion}/remote/#{endpoint}"

Botx::request = (endpoint, params) ->
  endpoint = ENDPOINTS[endpoint]
  params = toSnake params
  params.api_key = @apiKey
  params.project_id = @projectId

  try
    switch endpoint.method
      when 'get'
        res = await axios.get @getUrl(endpoint.url),
          params: params
      when 'post'
        res = await axios.post @getUrl(endpoint.url), params
      when 'put'
        res = await axios.put @getUrl(endpoint.url), params
      else
        throw new Error 'Unknown request method'
    toCamel res.data
  catch e
    if e.response && e.response.data && e.response.data.errors && e.response.data.errors.full_messages && Array.isArray(e.response.data.errors.full_messages)
      throw new Error errorToCamel e.response.data.errors.full_messages[0]
    if e.response && e.response.data && Array.isArray e.response.data.errors
      throw new Error errorToCamel e.response.data.errors[0]
    if e.response && e.response.data.error
      throw errorToCamel e.response.data.error
    if e.response && e.response.data
      throw errorToCamel e.response.data
    throw errorToCamel e

Botx::_capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Botx::parseNotification = (notification) ->
  if @redis
    notificationExist = await @checkNotificationExist notification
  if @redis && notificationExist
    return
  try
    ipnCallback = new IpnCallback @, notification
    ipnCallback.transaction
  catch err
    throw err

Botx::handler = (notification) ->
  unless notification && notification.transaction then return
  transaction = await @parseNotification notification
  @emit 'transaction', transaction
  transaction

module.exports = Botx

# components
require './components/market.coffee'
require './components/individual.coffee'
require './components/sockets.coffee'