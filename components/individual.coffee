Botx = require '../Botx.coffee'
Transaction = require '../Transaction.coffee'
{toCamel, toSnake, errorToCamel} = require '../helpers.coffee'

Botx::loadIndividualItems = (filters = {}) ->
  await @request 'loadIndividualItems', filters

Botx::loadTradeoffers = (params = {}) ->
  tradeoffers = await @request "loadTradeoffers", params
  tradeoffers.tradeoffers

Botx::sendTradeoffer = (tradeoffer = {}) ->
  unless tradeoffer.uid
    throw new Error 'errors.uidIsRequired'

  unless tradeoffer.token
    throw new Error 'errors.tokenIsRequired'

  unless tradeoffer.message
    throw new Error 'errors.messageIsRequired'

  await @request 'sendTradeoffer', tradeoffer: tradeoffer

Botx::getTradeoffer = (id = "") ->
  await @request 'getTradeofferById', id: id

