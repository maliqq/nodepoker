var http = require('http')

require('./pokernode/suit')
require('./pokernode/kind')
require('./pokernode/card')
require('./pokernode/deck')
require('./pokernode/deal')
require('./pokernode/hand')

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html; charset=UTF8'});
  var deal = new Deal(5)
  s = deal.toString()
  s = s.replace(/♠/g, '<font color=black>♠</font>')
  s = s.replace(/♥/g, '<font color=red>♥</font>')
  s = s.replace(/♦/g, '<font color=blue>♦</font>')
  s = s.replace(/♣/g, '<font color=green>♣</font>')
  res.end("<pre>" + s + "</pre>");
}).listen(1337, "127.0.0.1");
