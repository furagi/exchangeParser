class RatesController
	constructor: ->

	getRates: (req, res, sources) ->
		cur =  req.query.cur
		base = req.query.base
		# Мы отправляем клиенту все данные одним куском, а не отдельно по каждому источнику,
		#т.к. иначе клиент никогда не узнает, где конец.
		ratesCollection = {}
		limit = 0
		
		sendRates = @_sendRates
		for source, getterInfo of sources
			limit++
			ratesCollection[source] = {}
			ratesCollection[source].error = off
			ratesCollection[source].descriptions = []
			do (source, getterInfo) ->
				getter = new getterInfo['class']

				getter.on 'error', (err) =>
					console.log source + ': ' + err
					ratesCollection[source].error = on
					ratesCollection[source].descriptions.push err
				
				getter.on 'end', (rates) =>
					ratesCollection[source].rates = rates
					getter = null
					limit--
					if not limit
						sendRates res, base, cur, ratesCollection

				getter.getRates base, cur, getterInfo.key

	_sendRates: (res, base, currencys, collection) ->
		console.log collection
		data = {}
		data.base = base
		data.error = off
		data.errors = {}
		ratesCollection = {}
		sources = []
		for source, info of collection
			sources.push source
			if info.error
				data.error = on
				data.errors[source] = info.descriptions

			for cur, rate of info.rates
				if not ratesCollection[cur]?
					ratesCollection[cur] = {}
				ratesCollection[cur][source] = rate
		data.ratesCollection = ratesCollection
		data.sources = sources
		res.send data


exports.RatesController = RatesController
