# @author    Gleb Vishnevsky (nfteam.ru/gleb.vishnevsky)
# @copyright Copyright (c) 2017 Gleb Vishnevsky
# @license   https://opensource.org/licenses/MIT The MIT License (MIT)

snake = require 'to-snake-case'
camel = require 'to-camel-case'

toSnake = (params) ->
  if Array.isArray params
    return params.map (param) =>
      toSnake param

  if typeof params == 'object'
    ret = {}
    for param of params
      ret[snake(param)] = toSnake params[param]
    return ret

  return params

toCamel = (params) ->
  if Array.isArray params
    return params.map (param) =>
      toCamel param

  if typeof params == 'object'
    ret = {}
    for param of params
      ret[camel(param)] = toCamel params[param]
    return ret

  return params

errorToCamel = (str) ->
  str.replace /(\_\w)/g, (m) ->
    return m[1].toUpperCase()

module.exports = 
  toCamel: toCamel
  toSnake: toSnake
  errorToCamel: errorToCamel