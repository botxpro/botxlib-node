Botx = require '../Botx.coffee'
Transaction = require '../Transaction.coffee'
{toCamel, toSnake, errorToCamel} = require './helpers.coffee'

Botx::loadUserInventory = (params = {}) ->
  unless params.uid
    throw new Error 'errors.uidIsRequired'
  inventory = await @request "load#{@_capitalize(@projectType)}UserInventory", params
  inventory.items

Botx::deposit = (params = {}) ->
  res = await @request 'deposit', deposit: params
  new Transaction res.transaction

Botx::withdraw = (params = {}) ->
  @checkWithdrawItems toCamel params.items
  res = await @request 'withdraw', withdraw: params
  new Transaction res.transaction

Botx::loadMarketItems = (filters = {}) ->
  await @request 'loadMarketItems', filters