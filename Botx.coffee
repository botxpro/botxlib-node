snake = require 'to-snake-case'
camel = require 'to-camel-case'
axios = require 'axios'
ENDPOINTS = require './enums/endpoints.coffee'

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

Botx::loadUserInventory = (params = {}) ->
  unless params.uid
    throw new Error 'uid is required'
  inventory = await @request "load#{@_capitalize(@projectType)}UserInventory", params
  inventory.items


Botx::getUrl = (endpoint) ->
  return "#{@apiUrl}/#{@apiVersion}/remote/#{endpoint}"

Botx::buildParams = (params) ->
  if Array.isArray params
    return params.map (param) =>
      @buildParams param

  if typeof params == 'object'
    ret = {}
    for param of params
      ret[snake(param)] = @buildParams params[param]
    return ret

  return params

Botx::buildRes = (params) ->
  if Array.isArray params
    return params.map (param) =>
      @buildRes param

  if typeof params == 'object'
    ret = {}
    for param of params
      ret[camel(param)] = @buildRes params[param]
    return ret

  return params

Botx::request = (endpoint, params) ->
  endpoint = ENDPOINTS[endpoint]
  params = @buildParams params
  params.api_key = @apiKey
  params.project_id = @projectId

  try
    if endpoint.method == 'get'
      res = await axios.get @getUrl(endpoint.url),
        params: params
    else
      res = await axios.post @getUrl(endpoint.url), params
    @buildRes res.data
  catch e
    if e.response && e.response.data && Array.isArray e.response.data.errors
      throw new Error e.response.data.errors[0]
    if e.response && e.response.data
      throw e.response.data
    throw e

Botx::_capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1);

module.exports = Botx