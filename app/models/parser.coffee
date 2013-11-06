EventEmitter = require('events').EventEmitter

class Parser extends EventEmitter
	constructor: ->
		http = require 'http'
		@_get = http.get
	
	
	#base - base currency, currencys - array of identificators. Ex.: getRate 'EUR', ['AUD', 'NOK', 'USD']
	getRates: (base, currencys) ->  
		
	
	_getData: (url) ->
		try
			@_get url, (res) =>
				body = ''
				res.on 'end', =>
					@_parse body
				res.on 'data', (chunk) =>
					body += chunk
			.on 'error', (e) =>
				@emit 'error', e.message
		catch err
			@emit 'error', err


	_parse: (data) ->
		# ...
	

	
exports.Parser = Parser