module.exports = Botx = require './Botx.coffee'

botx = new Botx
  projectType: 'market'
  projectId: 14
  apiKey: '5l5k1PFj-JPwDqq6SRSqPg'
  # redis: {}

# botx.deposit 
#   uid: '76561198078016715'
#   token: 'bT7eJeTM'
#   message: 'Hello! My friend'
#   their_items: [
#     appid: 730
#     contextid: 2
#     assetid: 13460737036
#   ]
# .then (res) => 
#   console.log 'res', res
# .catch (err) =>
#   console.log 'err', err

# notification = 
#   "sign": "a9c8ad285cefcd209f0d2041cc10154b77a089d304951bd70f36b57e17583180",
#   "transaction": {
#     "amount": "23.03",
#     "created_at": "2018-01-23T22:21:19.255Z",
#     "description": "",
#     "details": {
#       "items_to_receive": [
#         {
#           "appid": 730,
#           "assetid": "13460737036",
#           "classid": "2431988480",
#           "contextid": 2,
#           "csgo": {
#             "inspect_link": "steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S76561198078016715A13460737036D10280638815808614701",
#             "stickers": [
#               {
#                 "name": "FaZe Clan | Krakow 2017",
#                 "src": "https://steamcdn-a.akamaihd.net/apps/730/icons/econ/stickers/krakow2017/faze.3e447b71c9db56991508b4253c23e2e43a02168a.png"
#               },
#               {
#                 "name": "FaZe Clan | Krakow 2017",
#                 "src": "https://steamcdn-a.akamaihd.net/apps/730/icons/econ/stickers/krakow2017/faze.3e447b71c9db56991508b4253c23e2e43a02168a.png"
#               },
#               {
#                 "name": "FaZe Clan | Krakow 2017",
#                 "src": "https://steamcdn-a.akamaihd.net/apps/730/icons/econ/stickers/krakow2017/faze.3e447b71c9db56991508b4253c23e2e43a02168a.png"
#               }
#             ]
#           },
#           "instanceid": 480085569,
#           "market_hash_name": "USP-S | Kill Confirmed (Field-Tested)",
#           "marketable": true,
#           "name": "USP-S | Kill Confirmed",
#           "name_color": "D2D2D2",
#           "prices": {
#             "our_price": "23.74",
#             "raw_data": {
#               "avg30_1yr": 26.41555,
#               "avg60_1yr": 27.20693,
#               "avg7_1yr": 25.39771,
#               "avg_daily_volume": "57",
#               "avg_price_30_days": "31.54",
#               "avg_price_30_days_raw": 31.53749,
#               "avg_price_60_days": "29.48",
#               "avg_price_60_days_raw": 29.48469,
#               "avg_price_7_days": "31.66",
#               "avg_price_7_days_raw": 31.65857,
#               "current_price": "34.24",
#               "current_price_last_checked": "2018-01-23 15:57:29",
#               "img": "https://steamcommunity-a.akamaihd.net/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXH5ApeO4YmlhxYQknCRvCo04DEVlxkKgpoo6m1FBRp3_bGcjhQ09-jq5WYh8j_OrfdqWhe5sN4mOTE8bP4jVC9vh4DPzixc9OLcQU2Z1vQ_FfrwbvnhJ6-uJ_PnXAyuCUmtHfenRW00h5MPOVt1_KYHULeWfL4W83H_Q",
#               "link": "http://csgo.steamanalyst.com/id/146893968/",
#               "market_name": "USP-S | Kill Confirmed (Field-Tested)",
#               "ongoing_price_manipulation": "0",
#               "rarity": "Covert Pistol",
#               "sold_last_24h": "70",
#               "sold_last_7d": "402"
#             },
#             "steam_price": "31.66"
#           },
#           "tags": [
#             {
#               "category": "Type",
#               "category_name": "Type",
#               "color": "",
#               "internal_name": "CSGO_Type_Pistol",
#               "name": "Pistol"
#             },
#             {
#               "category": "Weapon",
#               "category_name": "Weapon",
#               "color": "",
#               "internal_name": "weapon_usp_silencer",
#               "name": "USP-S"
#             },
#             {
#               "category": "ItemSet",
#               "category_name": "Collection",
#               "color": "",
#               "internal_name": "set_community_9",
#               "name": "The Shadow Collection"
#             },
#             {
#               "category": "Quality",
#               "category_name": "Category",
#               "color": "",
#               "internal_name": "normal",
#               "name": "Normal"
#             },
#             {
#               "category": "Rarity",
#               "category_name": "Quality",
#               "color": "eb4b4b",
#               "internal_name": "Rarity_Ancient_Weapon",
#               "name": "Covert"
#             },
#             {
#               "category": "Exterior",
#               "category_name": "Exterior",
#               "color": "",
#               "internal_name": "WearCategory2",
#               "name": "Field-Tested"
#             },
#             {
#               "category": "Tournament",
#               "category_name": "Tournament",
#               "color": "",
#               "internal_name": "Tournament12",
#               "name": "2017 PGL Krakow"
#             },
#             {
#               "category": "TournamentTeam",
#               "category_name": "Team",
#               "color": "",
#               "internal_name": "Team61",
#               "name": "FaZe Clan"
#             }
#           ],
#           "tradable": true,
#           "type": "Covert Pistol",
#           "uid": "76561198078016715"
#         }
#       ]
#     },
#     "fee_amount": "0.71",
#     "fee_percent": 3,
#     "id": 4371,
#     "state": "pending",
#     "steam_amount": "31.66",
#     "tradeoffer": {
#       "bot_id": "76561198350509648",
#       "created_at": "2018-01-23T22:21:20.960+00:00",
#       "expires": "2018-02-06",
#       "is_our_offer": true,
#       "message": "Hello! My friend",
#       "offer_id": "2901893194",
#       "partner": "76561198078016715",
#       "state": 2,
#       "state_name": "Active",
#       "updated_at": "2018-01-23T22:21:20.963+00:00"
#     },
#     "type": "deposit"
#   }

# botx.handler notification
# .then (transaction) ->
#   console.log transaction
# .catch (err) ->
#   console.log err