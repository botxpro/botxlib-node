module.exports =
  loadItemSettings:
    method: 'get'
    url: 'item_settings'
  loadItemSettingsCompact:
    method: 'get'
    url: 'item_settings/prices'
  loadMarketItems:
    method: 'get'
    url: 'market/items'
  loadMarketUserInventory:
    method: 'get'
    url: 'market/inventories'
  deposit:
    method: 'post'
    url: 'market/deposit'
  withdraw:
    method: 'post'
    url: 'market/withdraw'
  tokens:
    method: 'get'
    url: 'tokens'
  loadIndividualItems:
    method: 'get'
    url: 'individual/items'
  loadTradeoffers:
    method: 'get'
    url: 'individual/tradeoffers'
  sendTradeoffer:
    method: 'post'
    url: 'individual/tradeoffers'
  getTradeofferById:
    method: 'get'
    url: 'individual/tradeoffers'
  loadIndividualUserInventory:
    method: 'get'
    url: 'individual/inventories'
  respondToTradeoffer:
    method: 'put'
    url: 'individual/tradeoffers'
