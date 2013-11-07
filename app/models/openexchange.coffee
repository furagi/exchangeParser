Parser = require(__dirname + '/parser').Parser
class OpenExchange extends Parser
	constructor: ->
		@getRates = @getLatest

	getLatest: (base, currencys, key, https = false) ->
		url = "http#{if https then 's' else ''}://openexchangerates.org/api/"
		
		protocol = undefined
		if https
			protocol = require 'https'
		else
			protocol = require 'http'
		@_get = protocol.get

		@_base = base
		@_currencys = currencys

		@_getData url + 'latest.json?app_id=' + key
			
		




	_parse: (data) ->
		if not data?
			@_onParseError 'Can\'t get from openexchange.org' 
			return

		try
			data = JSON.parse data
		catch e
			@_onParseError e
			return

		if data.error
			@_onParseError data.description
			return

		b = data.base
		
		if b isnt @_base
			cost = data.rates[@_base]
			data.rates[b] = 1

		cur = {}
		for i in [0...@_currencys.length]
			cur[@_currencys[i]] = Math.round( data.rates[@_currencys[i]] / cost * 10000) / 10000

		@emit 'end', cur
		


exports.OpenExchange = OpenExchange