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