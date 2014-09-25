data = require './data/user'

module.exports = (req, res) ->
  username = req.get('username')
  password = req.get('password')
  if not username? or not password? then res.status(401).end()
  else 
    setTimeout ->
      res.send(data)
    , 1500