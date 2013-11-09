EventEmitter = require('events').EventEmitter

class Parser extends EventEmitter
	constructor: ->
		@_ratesInfo = {}
		@_ratesInfo.error = off
		@_ratesInfo.descriptions = []
		http = require 'http'
		@_get = http.get
		@_init()
	
	
	@_init: ->
		
	
	
	#base - base currency, currencys - array of identificators. Ex.: getRate 'EUR', ['AUD', 'NOK', 'USD']
	getRates: (base, currencys) ->  
		

	_getData: (url) ->
		try
			@_get url, (res) =>
				body = ''
				res.on 'end', =>
					if body?
						@_parse body
					else 
						@_onError 'Can\'t get data'
				res.on 'data', (chunk) =>
					body += chunk
			.on 'error', (e) =>
				@_onError e.message
		catch err
			@_onError err

	_onError: (err) ->
		@emit err
		@_ratesInfo.error = on
		@_ratesInfo.descriptions.push err
		@emit 'end', @_ratesInfo

	_parse: (data) ->
		# ...
	

	# _onParseError: (err) ->
	# 	@emit 'error', err
	# 	cur = {}
	# 	@emit 'end', cur

	
exports.Parser = Parser