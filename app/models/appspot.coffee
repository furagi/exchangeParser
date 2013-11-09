Parser = require(__dirname + '/parser').Parser


class AppSpot extends Parser
		
		
	getRates: (base, currencys, key) ->
		url = 'http://currency-api.appspot.com/api/'
		@_curLength = currencys.length
		@_ratesInfo.rates = {}

		for i in [0...currencys.length]
			@_getData url + base + "/#{currencys[i]}.json?key=" + key

			
		
	_onError: (err) ->
		@_ratesInfo.error = on
		@_ratesInfo.descriptions.push err
		if not @_curLength
			@emit 'end', @_ratesInfo

	_parse: (data) ->
		@_curLength--

		try
			data = JSON.parse data
		catch e
			@_onError e
			return
		
		if not data.success
			@_onError data.message 
			return

		@_ratesInfo.rates[data.target] = data.rate
		if not @_curLength
			@emit 'end', @_ratesInfo
		


exports.AppSpot = AppSpot