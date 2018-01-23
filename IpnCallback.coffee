# @author    Gleb Vishnevsky (nfteam.ru/gleb.vishnevsky)
# @copyright Copyright (c) 2017 Gleb Vishnevsky
# @license   https://opensource.org/licenses/MIT The MIT License (MIT)

sha256 = require 'sha256'
safeCompare = require 'safe-compare'
{toCamel, toSnake} = require './helpers.coffee'

Transaction = require './Transaction.coffee'

class IpnCallback
  constructor: (@botx, @notifiation) ->
    if typeof @notifiation != 'object'
      try
        @notifiation = JSON.parse @notifiation
      catch err
        throw new Error 'errors.cannot_parse_json'

    @signature = @notifiation.sign
    @transaction = new Transaction @notifiation.transaction
    
    do @checkSignature

IpnCallback::checkSignature = ->
  unless safeCompare @signature, do @calculateSignature
    throw new Error 'errors.wrong_signature'

IpnCallback::calculateSignature = ->
  params = [
    @transaction.id, 
    @botx.projectId, 
    @transaction.type, 
    @transaction.amount, 
    @transaction.steamAmount, 
    @transaction.state, 
    @botx.apiKey
  ]
  sha256 "{#{params.join '}{'}}"

module.exports = IpnCallback