express = require 'express'
fs = require 'fs'



RatesController = require(__dirname + '/app/controllers/ratescontroller').RatesController
OpenExchange = require(__dirname + '/app/models/openexchange').OpenExchange
AppSpot = require(__dirname +  '/app/models/appspot').AppSpot
EuropeanCB = require(__dirname +  '/app/models/ecb').EuropeanCB
ForbiddenController = require(__dirname + '/app/controllers/forbidden').ForbiddenController



app = express()
app.use express.logger('dev')
app.use express.bodyParser()
app.use app.router
app.use(express.static(__dirname, 'public'))


fs.readFile __dirname + '/config.json',  (err, data) =>
	if err 
		throw err

	data = JSON.parse data
	

	data.sources['openexchangerates.org']['class'] = OpenExchange
	data.sources['appspot.com']['class'] = AppSpot
	data.sources['ecb.int']['class'] = EuropeanCB



	app.get '/api/rates', (req, res) =>
		rates = new RatesController()
		rates.getRates(req, res, data.sources)
		

	app.listen data.port, ->
		console.log "Express server listening on port #{data.port}"





