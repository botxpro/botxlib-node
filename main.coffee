Botx = require './Botx.coffee'

botx = new Botx
  projectType: 'market'
  projectId: 13
  apiKey: 'W1L62DiZI-67Z9BVB69wRQ'

botx.loadItemSettings()
.then (res) => 
  console.log 'res', res
.catch (err) =>
  console.log 'err', err