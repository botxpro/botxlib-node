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

Botx::respondToTradeoffer = (offer_id = "", partner = "", bot_id = "", action = "") ->
  await @request 'respondToTradeoffer', 
    tradeoffer:
      offer_id: offer_id
      partner: partner
      bot_id: bot_id
    action: action

Botx::getTradeoffer = (id = "") ->
  await @request 'getTradeofferById', id: id

