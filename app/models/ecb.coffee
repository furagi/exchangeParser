Parser = require(__dirname + '/parser').Parser

class EuropeanCB extends Parser
		 
	getRates: (base, currencys) ->
		url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
		
		@_base = base
		@_currencys = currencys

		@_getData url
			
		

		
	_parse: (data) ->
		{parseString} = require 'xml2js'
		

		parseString data, {async: on}, (err, result) =>
			if err
				@_onError err
				return
			
			data = result['gesmes:Envelope'].Cube[0].Cube[0].Cube
			currencys = {}

			for i in [0...data.length]
				currencys[data[i]['$'].currency] = data[i]['$'].rate
			
			cost = 1
			if currencys[@_base]
				cost = currencys[@_base]

			@_ratesInfo.rates = {}
		
			for i in [0...@_currencys.length]
				@_ratesInfo.rates[@_currencys[i]] = currencys[@_currencys[i]] / cost

			@emit 'end', @_ratesInfo			
		


exports.EuropeanCB = EuropeanCB