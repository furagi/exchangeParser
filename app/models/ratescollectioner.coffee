class RatesCollectioner
	constructor: ->
	

	start: (sources, interval, base, currencys) ->
		@_tID = setInterval @_getRates, interval



	stop: ->
		clearInterval @_tID


	restart: (sources, interval, base, currencys) ->
		@stop @_tID
		start sources, interval, base, currencys
	
	
	

	_getRates: (sources) =>
		ratesCollection = {}
		limit = 0
		
		sendRates = @_sendRates
		for source, getterInfo of sources
			limit++
			# ratesCollection[source] = {}
			# ratesCollection[source].error = off
			# ratesCollection[source].descriptions = []

			do (source, getterInfo) ->
				getter = new getterInfo['class']

				getter.on 'error', (err) =>
					console.log source + ': ' + err
					# ratesCollection[source].error = on
					# ratesCollection[source].descriptions.push err
				
				getter.on 'end', (rates) =>
					ratesCollection[source] = rates
					getter = null
					limit--
					if not limit
						sendRates res, base, cur, ratesCollection

				getter.getRates base, cur, getterInfo.key

	_updateRates: (base, currencys, collection) ->
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

