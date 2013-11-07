<!doctype html>
<html>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<head>
		<!-- <link href="css/bootstrap.css" rel="stylesheet"> -->
		<script src="js/ratesctrl.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.6/angular.min.js"></script>
		<title>Exchange Indexer</title>
	</head>
	<body>
		<div ng-controller="RatesCtrl">
			<h1>
				This page performs gathering of exchange rates from {{getSourcesList()}}
			</h1>
			<table>
				<tr>
					<td>{{getBase()}}</td>
					<td ng-repeat="source in sources">{{source}}</td>
				</tr>
				<tr ng-repeat="(currency, rates) in ratesCollection">
					<td>{{currency}}</td>
					<td ng-repeat="source in sources">{{rates[source]}}</td>
				</tr>
			</table>
			<span class="done-{{error}}">
				Error! Please, copy text belowe, and send it to furagi.usagi@gmail.com. Thanks.
				{{errorMsg}}
			</span>
		</div>		
	</body>
</html>
