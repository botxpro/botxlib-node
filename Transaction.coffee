# @author    Gleb Vishnevsky (nfteam.ru/gleb.vishnevsky)
# @copyright Copyright (c) 2017 Gleb Vishnevsky
# @license   https://opensource.org/licenses/MIT The MIT License (MIT)

{toCamel, toSnake} = require './helpers.coffee'

class Transaction
  constructor: (transaction) ->
    transaction = toCamel transaction

    for key of transaction
      @[key] = transaction[key]

module.exports = Transaction