express = require 'express'
path = require 'path'
RatesController = require(path.join __dirname + '/app/controllers/ratescontroller').RatesController
OpenExchange = require(path.join __dirname +  '/app/models/openexchange').OpenExchange
AppSpot = require(path.join __dirname +  '/app/models/appspot').AppSpot
EuropeanCB = require(path.join __dirname +  '/app/models/ecb').EuropeanCB
app = express()

app.use express.logger('dev')
app.use express.bodyParser()
app.use app.router
app.use(express.static(path.join __dirname, 'public'))
 

sources = {}
sources['openexchangerates.org'] = {
	key: '499ff87d058c4470ad9da91b4477b5a8', 
	'class': OpenExchange
	}

sources['appspot.com'] = {
	key: '05a9ff8fad66f5a6f6a87df95e8b97396dba7160', 
	'class': AppSpot
	}

sources['ecb.int'] = {
	'class': EuropeanCB
	}

rates = new RatesController()

app.get '/api/rates', (req, res) =>
	rates.getRates(req, res, sources)
	

app.listen 8080, ->
	console.log 'Express server listening on port 8080'

