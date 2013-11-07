express = require 'express'
path = require 'path'
app = express()

app.use express.logger('dev')
app.use express.bodyParser()
app.use app.router
app.use(express.static(path.join __dirname, 'public'))
 

# sources = {}
# sources['openexchangerates.org'] = {
# 	key: '499ff87d058c4470ad9da91b4477b5a8', 
# 	'class': OpenExchange
# 	}

# sources['appspot.com'] = {
# 	key: '05a9ff8fad66f5a6f6a87df95e8b97396dba7160', 
# 	'class': AppSpot
# 	}

# sources['ecb.int'] = {
# 	'class': EuropeanCB
# 	}


fs = require 'fs'
fs.readFile path.join(__dirname + '/config.json'),  (err, data) =>
	if err 
		throw err

	data = JSON.parse data
	

	RatesController = require(path.join __dirname + '/app/controllers/ratescontroller').RatesController
	OpenExchange = require(path.join __dirname + '/app/models/openexchange').OpenExchange
	AppSpot = require(path.join __dirname +  '/app/models/appspot').AppSpot
	EuropeanCB = require(path.join __dirname +  '/app/models/ecb').EuropeanCB
	

	data.sources['openexchangerates.org']['class'] = OpenExchange
	data.sources['appspot.com']['class'] = AppSpot
	data.sources['ecb.int']['class'] = EuropeanCB

	app.get '/api/rates', (req, res) =>
		rates = new RatesController()
		rates.getRates(req, res, data.sources)
		

	app.listen data.port, ->
		console.log 'Express server listening on port 8080'





