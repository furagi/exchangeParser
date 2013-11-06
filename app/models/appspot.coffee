#05a9ff8fad66f5a6f6a87df95e8b97396dba7160
#http://currency-api.appspot.com/api/{source}/{target}.json?key={key}
Parser = require(__dirname + '/parser').Parser


class AppSpot extends Parser
		
		
	getRates: (base, currencys, key) ->
		url = 'http://currency-api.appspot.com/api/'
		@_curLength = currencys.length
		@_cur = {}

		for i in [0...currencys.length]
			@_getData url + base + "/#{currencys[i]}.json?key=" + key

			
		
	_onParseError: (msg) ->
		@emit 'error', msg
		if not @_curLength
			@emit 'end', @_cur

	_parse: (data) ->
		@_curLength--
		try
			data = JSON.parse data
		catch e
			@_onParseError e
			return
		
		if not data.success
			@_onParseError data.message 
			return

		@_cur[data.target] = data.rate
		if not @_curLength
			@emit 'end', @_cur
		


exports.AppSpot = AppSpot