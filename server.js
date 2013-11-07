// Generated by CoffeeScript 1.6.3
(function() {
  var AppSpot, EuropeanCB, ForbiddenController, OpenExchange, RatesController, app, express, fs,
    _this = this;

  express = require('express');

  fs = require('fs');

  RatesController = require(__dirname + '/app/controllers/ratescontroller').RatesController;

  OpenExchange = require(__dirname + '/app/models/openexchange').OpenExchange;

  AppSpot = require(__dirname + '/app/models/appspot').AppSpot;

  EuropeanCB = require(__dirname + '/app/models/ecb').EuropeanCB;

  ForbiddenController = require(__dirname + '/app/controllers/forbidden').ForbiddenController;

  app = express();

  app.use(express.logger('dev'));

  app.use(express.bodyParser());

  app.use(app.router);

  app.use(express["static"](__dirname, 'public'));

  fs.readFile(__dirname + '/config.json', function(err, data) {
    if (err) {
      throw err;
    }
    data = JSON.parse(data);
    data.sources['openexchangerates.org']['class'] = OpenExchange;
    data.sources['appspot.com']['class'] = AppSpot;
    data.sources['ecb.int']['class'] = EuropeanCB;
    app.get('/api/rates', function(req, res) {
      var rates;
      rates = new RatesController();
      return rates.getRates(req, res, data.sources);
    });
    return app.listen(data.port, function() {
      return console.log("Express server listening on port " + data.port);
    });
  });

}).call(this);
