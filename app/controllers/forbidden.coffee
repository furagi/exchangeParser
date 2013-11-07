class ForbiddenController
	constructor: ->
		# ...
	errorSend: (req, res) ->
		page = 'Page ' + req.path + 'not found'
		res.writeHead 404, {'content-type': 'text/html'}
		res.send page
	
		
