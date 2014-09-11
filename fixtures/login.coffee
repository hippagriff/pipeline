data = require './data/user'

module.exports = (req, res) ->
  username = req.get('username')
  password = req.get('password')
  console.log username, password
  if not username? or not password? then res.status(401).end()
  else res.send(data)