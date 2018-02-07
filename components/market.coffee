Botx = require '../Botx.coffee'
Transaction = require '../Transaction.coffee'
{toCamel, toSnake, errorToCamel} = require '../helpers.coffee'

Botx::loadUserInventory = (params = {}) ->
  unless params.uid
    throw new Error 'errors.uidIsRequired'
  inventory = await @request "load#{@_capitalize(@projectType)}UserInventory", params
  inventory.items

Botx::deposit = (params = {}) ->
  res = await @request 'deposit', deposit: params
  new Transaction res.transaction

Botx::withdraw = (params = {}) ->
  unless params.ignoreHashCheck
    @checkWithdrawItems toCamel params.items
  res = await @request 'withdraw', withdraw: params
  new Transaction res.transaction

Botx::loadMarketItems = (filters = {}) ->
  await @request 'loadMarketItems', filters

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



