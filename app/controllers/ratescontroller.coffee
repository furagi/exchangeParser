class RatesController
	constructor: ->

	getRates: (req, res, sources) ->
		cur =  req.query.cur
		base = req.query.base

		for source, getterInfo of sources
			do (source, getterInfo) ->
				getter = new getterInfo['class']

				getter.on 'error', (err) =>
					console.log source + ': ' + err
					data = {}
					data.error = err
					data.source = source
					res.send data

				getter.on 'end', (rates) =>
					data = {}
					data.source = source
					data.base = base
					data.rates = rates
					res.send data
					console.log data
					getter = null

				getter.getRates base, cur, getterInfo.key



exports.RatesController = RatesController
