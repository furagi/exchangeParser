Parser = require(__dirname + '/parser').Parser
class OpenExchange extends Parser
	_init: ->
		@getRates = @getLatest

	getLatest: (base, currencys, key, https = false) ->
		url = "http#{if https then 's' else ''}://openexchangerates.org/api/"
		
		if https
			@_get = (require 'https').get
		
		@_base = base
		@_currencys = currencys

		@_getData url + 'latest.json?app_id=' + key
			
		




	_parse: (data) ->
		try
			data = JSON.parse data
		catch e
			@_onError e
			return

		if data.error
			@_onError data.description
			return

		b = data.base
		
		if b isnt @_base
			cost = data.rates[@_base]
			data.rates[b] = 1

		@_ratesInfo.rates = {}
		for i in [0...@_currencys.length]
			@_ratesInfo.rates[@_currencys[i]] = Math.round( data.rates[@_currencys[i]] / cost * 10000) / 10000

		@emit 'end', @_ratesInfo
		


exports.OpenExchange = OpenExchange