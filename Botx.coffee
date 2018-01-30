# @author    Gleb Vishnevsky (nfteam.ru/gleb.vishnevsky)
# @copyright Copyright (c) 2017 Gleb Vishnevsky
# @license   https://opensource.org/licenses/MIT The MIT License (MIT)

axios = require 'axios'
sha256 = require 'sha256'
safeCompare = require 'safe-compare'
{toCamel, toSnake, errorToCamel} = require './helpers.coffee'

ENDPOINTS = require './enums/endpoints.coffee'
IpnCallback = require './IpnCallback.coffee'
Transaction = require './Transaction.coffee'

class Botx
  constructor: (@options = {}) ->
    @apiUrl = @options.apiUrl || 'https://api.botx.pro'
    @apiVersion = @options.apiVersion || 'v1'

    @projectId = @options.projectId
    @apiKey = @options.apiKey
    @projectType = @options.projectType

    unless @projectId && @apiKey
      throw new Error 'projectId and apiKey required'

    unless ['market', 'individual'].includes @projectType
      throw new Error "#{@projectType} is not valid project type"

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
    if endpoint.method == 'get'
      res = await axios.get @getUrl(endpoint.url),
        params: params
    else
      res = await axios.post @getUrl(endpoint.url), params
    toCamel res.data
  catch e
    if e.response && e.response.data && e.response.data.errors && e.response.data.errors.full_messages && Array.isArray(e.response.data.errors.full_messages)
      throw new Error errorToCamel e.response.data.errors.full_messages[0]
    if e.response && e.response.data && Array.isArray e.response.data.errors
      throw new Error errorToCamel e.response.data.errors[0]
    if e.response && e.response.data
      throw errorToCamel e.response.data
    throw errorToCamel e

Botx::_capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Botx::handler = (notification) ->
  try
    ipnCallback = new IpnCallback @, notification
    Promise.resolve ipnCallback.transaction
  catch err
    Promise.reject err

Botx::checkWithdrawItems = (items) ->
  unless items && items.length == 0
    throw new Error 'errors.itemsNotPassed'

  for item in items
    if @checkItemHash item 
      throw new Error 'errors.wrongHash'

  true

Botx::checkItemHash = (item) ->
  unless item then return false
  safeCompare item.hash, @calculateItemHash item

Botx::calculateItemHash = (item) ->
  params = [
    @item.appid, 
    @item.contextid, 
    @item.assetid, 
    @item.ourPrice, 
    @item.steamPrice, 
    @apiKey
  ]
  sha256 "{#{params.join '}{'}}"

# components
require './components/market.coffee'

module.exports = Botx