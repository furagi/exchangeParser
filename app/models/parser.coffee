EventEmitter = require('events').EventEmitter

class Parser extends EventEmitter
	constructor: ->
		http = require 'http'
		@_get = http.get
	
	
	#base - base currency, currencys - array of identificators. Ex.: getRate 'EUR', ['AUD', 'NOK', 'USD']
	getRates: (base, currencys) ->  
		
	_onGetDataError: (err) ->
		@emit 'error', err
		@_parse null

	_getData: (url) ->
		try
			@_get url, (res) =>
				body = ''
				res.on 'end', =>
					@_parse body
				res.on 'data', (chunk) =>
					body += chunk
			.on 'error', (e) =>
				@_onGetDataError e.message
		catch err
			@_onGetDataError err

	_parse: (data) ->
		# ...
	

	_onParseError: (err) ->
		@emit 'error', err
		cur = {}
		@emit 'end', cur

	
exports.Parser = Parser