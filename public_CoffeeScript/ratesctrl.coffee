class RatesCtrl
	constructor: ($scope, $http) ->
		$scope.base = 'EUR'
		interval = 20000
		apiUrl = '/api/rates'
		currencys = ['AUD', 'NOK', 'USD']



		$scope.sources = ['loading...']
		$scope.getSourcesList = ->
			$scope.sources.join ', '


		$scope.ratesCollection = {}
		$scope.error = false
		@_getRates  $http, $scope, apiUrl, currencys
		setInterval @_getRates, interval,  $http, $scope, apiUrl, currencys

		
	
	
	_getRates: (http, scope, apiUrl, currencys) ->
		
		params = '?base=' + scope.base
		for i in [0...currencys.length]
			params += '&cur=' + currencys[i]
		url = apiUrl + params
		http({method: 'GET', url: url}).
		success (data, status, headers, config) =>
			console.log  data
			scope.base = data.base
			scope.error = data.error
			if data.error
				scope.errorMsg = ''
				for  source, error of data.errors 
					scope.errorMsg+= "Error#{if error.legnth >= 1 then 's' else ''} while get information from #{source}: " + error.join '; '

			scope.ratesCollection = data.ratesCollection
			scope.sources = data.sources


		.error (data, status, headers, config) =>
			scope.error = true
			scope.errorMsg = "Connection error."






